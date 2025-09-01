import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onborading_screen/component/_widgets.dart';
import '../auth/auth_screen.dart';
import '../auth/forms/cubit/auth_Cubit.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  void _nextPage() {
    if (_currentIndex < onboardingData.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _goToAuth();
    }
  }

  void _skip() {
    _goToAuth();
  }

  void _goToAuth() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const AuthScreen(),
        ),
      ),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Column(
          children: [
            // App Logo
            appBranding(),

            // Expanded PageView (Image + fixed Dot + Text)
            Expanded(
              child: Stack(
                children: [
                  // PageView for Images
                  PageView.builder(
                    controller: _controller,
                    itemCount: onboardingData.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    itemBuilder: (_, index) {
                      final data = onboardingData[index];
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 175),
                          child: Container(
                            width: 350,
                            height: 375,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(
                              onboardingData[_currentIndex]["image"]!, // Use the "image" property, not "title"
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Fixed Dot Indicator + Title + Subtitle
                  Positioned(
                    bottom: 50,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        // Dot Indicator
                        SizedBox(
                          height: 10,
                          child: buildCustomDots(onboardingData.length, _currentIndex),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          onboardingData[_currentIndex]["title"]!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 12),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            onboardingData[_currentIndex]["subtitle"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12, color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Next / Sign in button
                  SizedBox(
                    width: double.infinity,
                    height: 43,
                    child: ElevatedButton(
                      onPressed: _nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFC2E96A),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentIndex == onboardingData.length - 1
                            ? "Sign in"
                            : "Next",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF286243),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Skip / Sign up button
                  SizedBox(
                    width: double.infinity,
                    height: 43,
                    child: ElevatedButton(
                      onPressed: _currentIndex == onboardingData.length-1 ? _goToAuth :_skip,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        side: const BorderSide(color: Colors.grey, width: 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        _currentIndex == onboardingData.length - 1
                            ? "Sign up"
                            : "Skip",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Color(0xFF286243),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

// Onboarding Data
final List<Map<String, String>> onboardingData = [
  {
    "title": "Team Up For Success",
    "subtitle":
    "Get ready to unleash your potential and witness the power of teamwork as we embark on this extraordinary project.",
    "image": "assets/onBoardingImage/image_01.png",
  },
  {
    "title": "User-Friendly at its Core",
    "subtitle":
    "Discover the essence of user-friendliness as our interface empowers you with intuitive controls and effortless interactions",
    "image": "assets/onBoardingImage/image_02.png",
  },
  {
    "title": "Easy Task Creation",
    "subtitle":
    "Quickly add tasks, set due dates, and add descriptions with ease using our task manager app. Simplify your workflow and stay organized.",
    "image": "assets/onBoardingImage/image_03.png",
  },
];

Widget buildCustomDots(int totalDots, int currentIndex) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(totalDots, (index) {
      return AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 3),
        width: index == currentIndex ? 15 : 15,
        height: 5,
        decoration: BoxDecoration(
          color: index == currentIndex ? Color(0xFF286243) : Colors.grey,
          borderRadius: BorderRadius.circular(4),
        ),
      );
    }),
  );
}