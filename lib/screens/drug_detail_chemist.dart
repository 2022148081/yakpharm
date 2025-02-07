import 'package:flutter/material.dart';
import 'package:yakpharm/utils/themes.dart';
import 'package:yakpharm/utils/hardcoding.dart';
import 'package:yakpharm/screens/review.dart'; 

class CDrugDetailPage extends StatefulWidget {
  const CDrugDetailPage({Key? key}) : super(key: key);

  @override
  _CDrugDetailPageState createState() => _CDrugDetailPageState();
}

class _CDrugDetailPageState extends State<CDrugDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.black),
            onPressed: () {},
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            height: 0.5,
            color: const Color(0xFFD5D5D5),
          ),
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 약 이미지
            Image.asset(
              'assets/images/drug_image.jpg',
              width: screenWidth,
              height: screenWidth * 0.75,
              fit: BoxFit.cover,
            ),
            // 약 이름과 주요 기능 박스
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 25.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  top: BorderSide(color: const Color(0xFFD5D5D5), width: 0.5),
                  bottom: BorderSide(color: const Color(0xFFD5D5D5), width: 0.5),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 약 이름과 주요 기능
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DrugDetailTexts.drugName,
                          style: AppFonts.medium.copyWith(
                            fontSize: 23,
                            color: AppColors.maintext,
                            height: 0.9,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          DrugDetailTexts.summary,
                          style: AppFonts.regular.copyWith(
                            fontSize: 15,
                            color: const Color(0xFF9a9a9a),
                            height: 0.9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10), // 약간의 간격
                  // 재고 찾기 버튼
                ],
              ),
            ),
            // 공유 및 저장 버튼
            Container(
              width: screenWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(color: Color(0xFFD5D5D5), width: 0.5),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildActionButton(Icons.reviews_outlined, "리뷰 보기"),
                  Container(
                    width: 1,
                    height: 20,
                    color: const Color(0xFFD5D5D5),
                  ),
                  _buildActionButton(Icons.favorite_border, "저장"),
                ],
              ),
            ),
            // 빈 박스
            Container(
              width: screenWidth,
              height: 10,
              color: const Color(0xFFF3F3F3),
            ),
            // 탭 및 내용
            Column(
              children: [
                Row(
                  children: [
                    _buildCustomTab(0, "기본 정보", screenWidth),
                    _buildCustomTab(1, "복약 정보", screenWidth),
                    _buildCustomTab(2, "주의사항", screenWidth),
                  ],
                ),
                FractionallySizedBox(
                  widthFactor: 42 / 44,
                  child: _buildTabContent(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (label == "리뷰 보기") {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewPage()),
            );
          }
        },
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppFonts.regular.copyWith(
                  fontSize: 16,
                  color: AppColors.maintext,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomTab(int index, String text, double screenWidth) {
    bool isSelected = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _tabController.index = index;
        });
      },
      child: Container(
        width: screenWidth / 3,
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFD9D9D9),
        ),
        child: Center(
          child: Text(
            text,
            style: AppFonts.regular.copyWith(
              fontSize: 18,
              color: isSelected ? AppColors.maintext : const Color(0xFF808080),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    List<Widget> tabContents = [
      _buildBasicInfoTab(),
      _buildPrescriptionTab(),
      _buildWarningTab(),
    ];
    return tabContents[_tabController.index];
  }

  Widget _buildBasicInfoTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDrugInfoSection("효능, 효과", [DrugDetailTexts.efficacyContent]),
          _buildDrugInfoSection("주요 성분", [DrugDetailTexts.ingredientsContent]),
        ],
      ),
    );
  }

  Widget _buildPrescriptionTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDrugInfoSection("복약 정보", DrugDetailTexts.prescriptionPoints),
        ],
      ),
    );
  }

  Widget _buildWarningTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDrugInfoSection("주의사항", DrugWarningTexts.prohibitionContent),
        ],
      ),
    );
  }

  Widget _buildDrugInfoSection(String title, List<String> content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.semibold.copyWith(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ...content.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Row(
                children: [
                  const Text("• "),
                  Expanded(
                    child: Text(
                      point,
                      style: AppFonts.regular.copyWith(
                        fontSize: 18,
                        color: AppColors.maintext,
                      ),
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}