import 'package:flutter/material.dart';
import 'package:yakpharm/utils/themes.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 샘플 리뷰 데이터
    final List<Map<String, dynamic>> reviews = [
      {
        "text": "약 효과는 괜찮았지만 캡슐이 너무 커서 삼키기 힘들었습니다. 복용 안내를 더 자세히 해주시면 좋을 것 같아요.",
        "rating": 3
      },
      {
        "text": "가격 대비 효과가 약간 부족한 것 같아요. 비슷한 성분의 다른 약과 차별점을 모르겠어요.",
        "rating": 2
      },
      {
        "text": "겨울철마다 자주 찾게 되는 약입니다. 한 번 품절되면 오래 걸리니 재고를 넉넉히 두는 게 좋을 것 같아요.",
        "rating": 5
      },
      {
        "text": "목감기 때문에 이 약을 복용했는데 정말 효과가 뛰어났습니다. 복용 후 하루 만에 목 상태가 많이 좋아졌어요.",
        "rating": 5
      },
      {
        "text": "이 약을 복용하고 나서 구토와 두통이 심해졌습니다. 제 체질에 맞지 않았던 것 같아요.",
        "rating": 1
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "리뷰 보기",
          style: AppFonts.medium.copyWith(
            fontSize: 20,
            color: Colors.black,
          ),
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
      body: reviews.isEmpty
          ? const Center(
              child: Text(
                "리뷰가 없습니다.",
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                final review = reviews[index];
                return _buildReviewTile(context, review['text'], review['rating']);
              },
            ),
    );
  }

  Widget _buildReviewTile(BuildContext context, String reviewText, int rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.orange,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    reviewText,
                    style: AppFonts.regular.copyWith(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}