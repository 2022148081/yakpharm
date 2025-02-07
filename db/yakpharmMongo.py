import pandas as pd
from pymongo import MongoClient
from datetime import datetime
import pytz

# ✅ 1. MongoDB 연결
client = MongoClient("mongodb+srv://ysjammit:ysjammit@cluster0.1771w.mongodb.net/")
db = client.yakpharm  # 'yakpharm' 데이터베이스 선택
collection = db.drug_pharmacies  # 'drug_pharmacies' 컬렉션 선택

# ✅ 2. 한국 시간(KST)으로 현재 시각 설정
kst = pytz.timezone('Asia/Seoul')
current_time = datetime.now(kst).isoformat()

# ✅ 3. CSV 파일 로드 (파일 경로는 사용자 환경에 맞게 변경 필요)
drug_file = "/Users/imchaeyun/yakpharm/yakpharm.drug.csv"
pharmacy_file = "/Users/imchaeyun/yakpharm/yakpharm.pharmacies.csv"
mapping_file = "/Users/imchaeyun/yakpharm/yak_with_pharm.csv"

# ✅ 4. CSV 데이터 불러오기 (인코딩 및 컬럼명 정리)
df_drugs = pd.read_csv(drug_file, encoding="utf-8")
df_pharmacies = pd.read_csv(pharmacy_file, encoding="utf-8")
df_mapping = pd.read_csv(mapping_file, encoding="utf-8")

# 컬럼명 공백 제거
df_drugs.columns = df_drugs.columns.str.strip()
df_pharmacies.columns = df_pharmacies.columns.str.strip()
df_mapping.columns = df_mapping.columns.str.strip()

# 🔍 CSV 파일에서 컬럼명 확인 (디버깅)
print("📌 df_drugs 컬럼명:", df_drugs.columns)
print("📌 df_pharmacies 컬럼명:", df_pharmacies.columns)
print("📌 df_mapping 컬럼명:", df_mapping.columns)

# ✅ 5. 약품명과 약국명을 ID로 매핑 (컬럼명 변경 반영)
if "name" in df_drugs.columns and "_id" in df_drugs.columns:
    drug_id_map = pd.Series(df_drugs["_id"].values, index=df_drugs["name"].astype(str).str.strip()).to_dict()
else:
    raise KeyError("🚨 'name' 또는 '_id' 컬럼을 찾을 수 없습니다. drug CSV 파일을 확인하세요.")

if "name" in df_pharmacies.columns and "_id" in df_pharmacies.columns:
    pharmacy_id_map = pd.Series(df_pharmacies["_id"].values, index=df_pharmacies["name"].astype(str).str.strip()).to_dict()
else:
    raise KeyError("🚨 'name' 또는 '_id' 컬럼을 찾을 수 없습니다. pharmacies CSV 파일을 확인하세요.")

# ✅ 6. 최종 데이터 변환 (약품 ID와 약국 ID 매핑)
documents = []
for _, row in df_mapping.iterrows():
    drug_name = str(row.get("drug", "")).strip()  # 약품명
    pharmacy_name = str(row.get("name", "")).strip()  # 약국명
    
    drug_id = drug_id_map.get(drug_name, None)
    pharmacy_id = pharmacy_id_map.get(pharmacy_name, None)

    if drug_id and pharmacy_id:
        documents.append({
            "drug_id": drug_id,
            "pharmacy_id": pharmacy_id,
            "last_updated": current_time
        })

# ✅ 7. MongoDB에 데이터 삽입
if documents:
    collection.insert_many(documents)
    print(f"✅ {len(documents)}개의 데이터를 성공적으로 삽입했습니다!")
else:
    print("⚠️ 삽입할 데이터가 없습니다. 매핑을 확인하세요.")