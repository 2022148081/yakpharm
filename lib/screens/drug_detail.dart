import 'package:flutter/material.dart';
import 'package:yakpharm/utils/themes.dart';
import 'package:yakpharm/utils/hardcoding.dart';
import 'package:yakpharm/screens/stock_check.dart';

class DrugDetailPage extends StatefulWidget {
  const DrugDetailPage({Key? key}) : super(key: key);

  @override
  _DrugDetailPageState createState() => _DrugDetailPageState();
}

class _DrugDetailPageState extends State<DrugDetailPage>
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const StockCheckPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColor, // 버튼 색상
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      "재고 찾기",
                      style: AppFonts.regular.copyWith(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildActionButton(Icons.share, "공유"),
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
              fontWeight: isSelected ? FontWeight.normal : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    // 각 탭의 내용
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
          _buildDrugInfoSection(
            title: "효능, 효과",
            content: [DrugDetailTexts.efficacyContent],
          ),
          _buildDrugInfoSection(
            title: "주요 성분",
            content: [DrugDetailTexts.ingredientsContent],
          ),
          _buildDrugInfoSection(
            title: "복용법",
            content: [
              DrugDetailTexts.dosageForAbove15,
              DrugDetailTexts.dosageFor8To15
            ],
          ),
          _buildDrugInfoSection(
            title: "제조/수입사",
            content: [DrugDetailTexts.manufacturerContent],
          ),
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
          _buildDrugInfoSection(
            title: DrugDetailTexts.prescriptionTitle,
            content: DrugDetailTexts.prescriptionPoints,
          ),
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
          _buildDrugInfoSection(
            title: DrugWarningTexts.prohibitionTitle,
            content: DrugWarningTexts.prohibitionContent,
          ),
        ],
      ),
    );
  }

  Widget _buildDrugInfoSection({
    required String title,
    required List<String> content,
  }) {
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
          ...content.map((point) => Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("• ", style: TextStyle(fontSize: 16)),
                    Expanded(
                      child: Text(
                        point,
                        style: AppFonts.regular.copyWith(
                          fontSize: 18,
                          height: 1.5,
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