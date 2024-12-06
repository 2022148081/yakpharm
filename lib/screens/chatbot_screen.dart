import 'package:flutter/material.dart';
import 'package:yakpharm/utils/themes.dart';
import 'package:yakpharm/screens/drug_detail.dart'; // DrugDetailPage import

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({Key? key}) : super(key: key);

  @override
  _ChatBotScreenState createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  final List<Map<String, String>> _messages = [
    {'role': 'bot', 'content': '어떤 약을 찾고 계신가요? 설명해 주세요!'}
  ];

  final List<Map<String, String>> _botReplies = [
    {'text': '얼마 전에 복용하신 목감기약을 찾으시는군요! 포장지나 알약이 어떤 색이었는지 기억하시나요?'},
    {'text': 'OO님의 설명을 토대로 추린 약의 후보는 다음과 같아요.', 'image': 'assets/images/chatbot_reply.png'},
  ];

  int _replyIndex = 0; // 챗봇의 응답 순서 관리
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
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
      backgroundColor: const Color(0xFFF6F6F6), // 채팅 배경색
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 15.0), // AppBar와 첫 메시지 간격 추가
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                if (message['role'] == 'bot') {
                  return ChatBotMessage(content: message['content']!, maxWidth: screenWidth * 0.7);
                } else {
                  return UserMessage(content: message['content']!, maxWidth: screenWidth * 0.7);
                }
              },
            ),
          ),
          Container(
            height: screenWidth * (9 / 40), // 입력창 높이 설정
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    maxLines: null, // 입력창 줄바꿈 허용
                    decoration: const InputDecoration(
                      hintText: "메시지를 입력하세요",
                      hintStyle: TextStyle(
                        color: Color(0xFFD9D9D9),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  color: const Color(0xFFD9D9D9), // 버튼 색 변경
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() {
                        // 사용자의 메시지를 추가
                        _messages.add({
                          'role': 'user',
                          'content': _controller.text,
                        });

                        // 챗봇의 응답 추가
                        Future.delayed(const Duration(milliseconds: 700), () {
                          if (_replyIndex < _botReplies.length) {
                            final reply = _botReplies[_replyIndex];
                            if (reply.containsKey('text')) {
                              _messages.add({
                                'role': 'bot',
                                'content': reply['text']!,
                              });
                            }
                            if (reply.containsKey('image')) {
                              _messages.add({
                                'role': 'bot',
                                'content': reply['image']!,
                              });
                            }
                            _replyIndex++;
                            setState(() {});
                          }
                        });
                        _controller.clear();
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBotMessage extends StatelessWidget {
  final String content;
  final double maxWidth;

  const ChatBotMessage({Key? key, required this.content, required this.maxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 이미지인지 텍스트인지 확인
    if (content.endsWith('.png') || content.endsWith('.jpg') || content.endsWith('.jpeg')) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 8.0),
            child: Image.asset(
              'assets/icons/chatbot_profile.png', // 챗봇 프로필 이미지
              width: 40,
              height: 40,
              fit: BoxFit.contain, // 원본 비율 유지
            ),
          ),
          Flexible(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DrugDetailPage()),
                );
              },
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth), // 이미지 너비 제한
                margin: const EdgeInsets.symmetric(vertical: 4.0),
                child: Image.asset(
                  content, // 이미지 경로
                  fit: BoxFit.cover, // 이미지가 잘리거나 찌그러지지 않도록 설정
                  errorBuilder: (context, error, stackTrace) {
                    return const Text(
                      '이미지를 불러올 수 없습니다.', // 에러 처리
                      style: TextStyle(color: Colors.red),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    }

    // 텍스트 말풍선 처리
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 8.0),
          child: Image.asset(
            'assets/icons/chatbot_profile.png', // 챗봇 프로필 이미지
            width: 40,
            height: 40,
            fit: BoxFit.contain, // 원본 비율 유지
          ),
        ),
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth), // 말풍선 너비 제한
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              content,
              style: AppFonts.regular.copyWith(fontSize: 18), // 폰트 스타일 및 크기 변경
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}

class UserMessage extends StatelessWidget {
  final String content;
  final double maxWidth;

  const UserMessage({Key? key, required this.content, required this.maxWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            constraints: BoxConstraints(maxWidth: maxWidth), // 말풍선 너비 제한
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            margin: const EdgeInsets.only(right: 15.0, top: 4.0, bottom: 4.0),
            decoration: BoxDecoration(
              color: AppColors.mainColor, // 메인 색상
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Text(
              content,
              style: AppFonts.regular.copyWith(
                fontSize: 18, // 폰트 크기
                color: Colors.white, // 텍스트 색상
              ),
              softWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}