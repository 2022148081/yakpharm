class DrugDetailTexts {
  // 약 정보 데이터 리스트
  static final List<Map<String, String>> data = [
    {
      'drugName': '화콜C코프',
      'summary': '인후통, 기침, 가래, 오한 등',
      'image': 'assets/images/drug_image.jpg',
    },
  ];

  // 약 이름
  static const String drugName = "화콜C코프연질캡슐";

  static const String summary = "인후통, 기침, 가래, 오한 등";

  // 약 상세 내용
  static const String efficacyContent =
      "감기의 제증상(인후통, 기침, 가래, 오한, 발열, 두통, 관절통, 근육통)의 완화";

  static const String ingredientsContent =
      "아세트아미노펜, 브롬페니라민말레산염, 수도에페드린염산염, 덱스트로메트로판브롬화수소산염수화물, 구아이페네신";

  // 복용법 (두 줄로 나뉨)
  static const String dosageForAbove15 =
      "만 15세 이상: 1회 2캡슐, 1일 3회, 식후 30분에 복용";
  static const String dosageFor8To15 =
      "만 8세~만 15세: 1회 1캡슐, 1일 3회, 식후 30분에 복용";

  // 제조/수입사
  static const String manufacturerContent = "회사명: 제이더블유중외제약";

  // 복약 정보
  static const String prescriptionTitle = "복약 정보";
  static const List<String> prescriptionPoints = [
    "충분한 물과 함께 투여하세요.",
    "전문가와 상의없이 다른 감기약과 병용하지 마세요.",
    "이 약의 투여기간 동안에는 가능한 금주하세요.",
    "간질환 환자나 신장질환 환자의 경우 전문가에게 미리 알리세요.",
    "감염증상을 은폐시켜 감염성 합병증 진단을 지연시킬 수 있어요."
  ];

  // 복약 아이콘 설명
  static const List<String> prescriptionIcons = [
    "충분한 물과 함께 드세요", // 첫 번째 아이콘 설명
    "알코올 X" // 두 번째 아이콘 설명
  ];
}

class DrugWarningTexts {
  // 복용 금지 대상
  static const String prohibitionTitle = "복용 금지 대상";
  static const List<String> prohibitionContent = [
    "3개월 미만 영아",
    "과민반응 병력자: 약 성분 또는 해열진통제 복용 후 알레르기 병력 있는 사람.",
    "특정 질환자: 간질환, 신질환, 심질환, 당뇨병, 고혈압 등 만성질환자"
  ];

  // 동시복용 주의
  static const String simultaneousUseTitle = "동시복용 주의";
  static const List<String> simultaneousUseContent = [
    "해열진통제: 아세트아미노펜 포함 제품과 동시복용 금지 (간손상 위험).",
    "진해거담제: 진정제, 항히스타민제, 다른 감기약과 동시복용 금지.",
    "MAO억제제: 복용 중이거나 중단 후 2주 이내 복용 금지."
  ];

  // 복용 중 주의사항
  static const String duringUseTitle = "복용 중 주의사항";
  static const List<String> duringUseContent = [
    "장기 복용 금지: 정해진 용법·용량 준수.",
    "음주 주의: 음주 후 복용 금지.",
    "의심 증상 발생 시: 발진, 구토, 활동 중증 증상 시 즉시 복용 중단 후 의사 상담."
  ];

  // 보관법
  static const String storageTitle = "보관법";
  static const List<String> storageContent = [
    "어린이 손 닿지 않는 곳",
    "습기·직사광선: 밀폐 보관, 서늘한 장소 유지."
  ];
}