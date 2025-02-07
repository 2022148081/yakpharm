import 'package:flutter/material.dart';
import 'package:yakpharm/utils/themes.dart';

class ReviewLeavePage extends StatefulWidget {
  const ReviewLeavePage({Key? key}) : super(key: key);

  @override
  _ReviewLeavePageState createState() => _ReviewLeavePageState();
}

class _ReviewLeavePageState extends State<ReviewLeavePage> {
  final TextEditingController _reviewController = TextEditingController();
  int _rating = 0; // 사용자 평점 저장 변수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        elevation: 0,
        title: const Text(
          "리뷰 남기기",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(
              "평점을 선택해주세요",
              style: AppFonts.medium.copyWith(
                fontSize: 18,
                color: AppColors.maintext,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = index + 1; // 1부터 5까지 설정
                    });
                  },
                  icon: Icon(
                    Icons.star,
                    color: index < _rating ? Colors.orange : Colors.grey,
                  ),
                );
              }),
            ),
            const SizedBox(height: 20),
            Text(
              "리뷰를 작성해주세요",
              style: AppFonts.medium.copyWith(
                fontSize: 18,
                color: AppColors.maintext,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "약에 대한 리뷰를 작성해주세요.",
                hintStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_reviewController.text.isNotEmpty && _rating > 0) {
                    _submitReview();
                  } else {
                    _showErrorDialog();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  "리뷰 제출",
                  style: AppFonts.regular.copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submitReview() {
    // 리뷰 제출 로직
    String review = _reviewController.text;
    int rating = _rating;

    // TODO: 제출 데이터를 서버나 데이터베이스에 저장하는 로직 추가
    Navigator.pop(context); // 이전 화면으로 돌아가기
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("오류"),
        content: const Text("평점과 리뷰를 모두 작성해주세요."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("확인"),
          ),
        ],
      ),
    );
  }
}