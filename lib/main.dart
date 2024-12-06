import 'package:flutter/material.dart';
import 'screens/loading.dart';
import 'screens/home.dart';
import 'screens/drug_search.dart';
import 'utils/themes.dart';

void main() {
  print("앱 실행 시작"); // 디버깅용
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("MyApp 빌드 중"); // 디버깅용
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingScreen(), // 초기 로딩 화면
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0), // 화면 양쪽 여백
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // 텍스트는 왼쪽 정렬
            children: [
              const SizedBox(height: 50), // 상단 여백
              // '약팜', '약팜에 오신 것을 환영합니다!' 텍스트 그룹
              Padding(
                padding: const EdgeInsets.only(bottom: 0, left: 20, top: 90), // SwiftUI의 .padding(0) 대응
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // 텍스트 왼쪽 정렬
                  children: [
                    Text(
                      '약팜',
                      style: AppFonts.bold.copyWith(
                        fontSize: 65,
                        color: AppColors.mainColor,
                        height: 0.9, // 텍스트 간 간격을 줄임
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      '약팜에 오신 것을\n환영합니다!',
                      style: AppFonts.regular.copyWith(
                        fontSize: 30,
                        color: Colors.black,
                        height: 1.2, // 텍스트 간 간격을 줄임
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 72), // 텍스트와 버튼 간 여백 확보
              // 버튼 두 개 중앙 정렬
              Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomButton(
                      title: '약사',
                      subtitle: '약사용 서비스 바로가기',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SearchPage(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20), // 버튼 간 간격
                    CustomButton(
                      title: '일반 사용자',
                      subtitle: '일반 사용자용 서비스 바로가기',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Spacer(), // 버튼과 하단 여백 확보
            ],
          ),
        ),
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.87;
    double buttonHeight = buttonWidth * (138 / 380); // 버튼의 가로:세로 비율 380:138

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: buttonWidth,
        height: buttonHeight,
        decoration: BoxDecoration(
          gradient: AppGradients.mainGradient,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Title - 왼쪽 위
            Positioned(
              left: 24,
              top: 21,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: title, // ex: 약사 / 일반 사용자
                      style: AppFonts.bold.copyWith(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                    TextSpan(
                      text: '이신가요?', // 뒤에 자동으로 붙는 텍스트
                      style: AppFonts.regular.copyWith(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Subtitle + 화살표 - 오른쪽 아래
            Positioned(
              right: 24,
              bottom: 13,
              child: Row(
                children: [
                  Text(
                    subtitle,
                    style: AppFonts.light.copyWith(
                      fontSize: 16, // 폰트 크기
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Image.asset(
                    'assets/icons/mainpageArrow.png',
                    width: 47,
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PharmacistServicePage extends StatelessWidget {
  const PharmacistServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('약사용 서비스'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('약사용 서비스 페이지'),
      ),
    );
  }
}

class UserServicePage extends StatelessWidget {
  const UserServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('일반 사용자 서비스'),
        backgroundColor: AppColors.mainColor,
      ),
      body: const Center(
        child: Text('일반 사용자용 서비스 페이지'),
      ),
    );
  }
}