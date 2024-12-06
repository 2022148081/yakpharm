import 'package:flutter/material.dart';
import 'package:yakpharm/utils/themes.dart'; // AppFonts import

class StockCheckPage extends StatelessWidget {
  const StockCheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "가까운 약국에서 재고를 확인하세요!",
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            height: 0.5,
            color: const Color(0xFFD5D5D5),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Map Image
          Image.asset(
            'assets/images/pharmacy.png',
            width: screenWidth,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 18.0),
              children: [
                _buildPharmacyTile(
                  name: "세란약국",
                  stock: "재고 있음",
                ),
                _buildPharmacyTile(
                  name: "독수리약국",
                  stock: "재고 조금 있음",
                ),
                _buildPharmacyTile(
                  name: "새현대약국",
                  stock: "재고 있음",
                ),
                _buildPharmacyTile(
                  name: "현우약국",
                  stock: "재고 없음",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPharmacyTile({
    required String name,
    required String stock,
  }) {
    return Column(
      children: [
        ListTile(
          title: Text(
            name,
            style: AppFonts.regular.copyWith(
              fontSize: 20,
              color: AppColors.maintext,
              decoration: TextDecoration.underline,
            ),
          ),
          subtitle: Text(
            stock,
            style: AppFonts.regular.copyWith(
              fontSize: 15,
              color: const Color(0xFF9a9a9a),
            ),
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.mainColor,
            size: 20,
          ),
          onTap: () {
            // 약국 상세 페이지로 이동하는 코드 추가 가능
          },
        ),
        const Divider(
          thickness: 0.5,
          color: Color(0xFFD5D5D5),
        ),
      ],
    );
  }
}