import 'package:flutter/material.dart';
import 'package:yakpharm/utils/hardcoding.dart';
import 'package:yakpharm/utils/themes.dart'; // AppFonts 사용
import 'package:yakpharm/screens/drug_detail_costomer.dart'; // DrugDetailPage import

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: "찾으시는 약 이름을 검색해주세요.",
            hintStyle: const TextStyle(color: Color(0xFFD9D9D9)),
            border: InputBorder.none,
            prefixIcon: const Icon(Icons.search, color: Color(0xFFD9D9D9)),
          ),
          onChanged: (query) => _searchDrugs(query),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(
            height: 0.5,
            color: const Color(0xFFD5D5D5),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: _searchResults.isEmpty
          ? const Center(
              child: Text(
                "검색 결과가 없습니다.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final drug = _searchResults[index];
                return _buildDrugTile(
                  imagePath: drug['image']!,
                  drugName: drug['drugName']!,
                  summary: drug['summary']!,
                );
              },
            ),
    );
  }

  void _searchDrugs(String query) {
    setState(() {
      if (query.isEmpty) {
        _searchResults = [];
      } else {
        _searchResults = DrugDetailTexts.data
            .where((drug) => drug['drugName']!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
      }
    });
  }
  Widget _buildDrugTile({
    required String imagePath,
    required String drugName,
    required String summary,
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0), // 내부 여백 설정
      leading: Container(
        width: 100,
        height: 75,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      title: Text(
        drugName,
        style: AppFonts.medium.copyWith(
          fontSize: 20,
          decoration: TextDecoration.underline,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        summary,
        style: AppFonts.regular.copyWith(
          fontSize: 15,
          color: Colors.grey,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.blue,
        size: 20,
      ),
      onTap: () {
        // DrugDetailPage로 네비게이션
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DrugDetailPage(),
          ),
        );
      },
    );
  }
}