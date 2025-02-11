import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_button.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/login.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<String> image = [
    "assets/images/onboarding1.png",
    "assets/images/onboarding2.png"
  ];
  final List<String> _descriptions = ["Stay on Task", "Get Started Panel"];
  final List<String> text1 = [
    "Stay disciplined with our tier based rewards system.",
    "Get the motivation you need when it matters most with our AI-powered coaching bot."
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                itemCount: image.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(
                      20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          image[index],
                          height: index == 0 ? 350 : 293,
                        ),
                        index == 0
                            ? SizedBox.shrink()
                            : SizedBox(
                                height: 50,
                              ),
                        AppText.appText(
                          _descriptions[index],
                          textColor: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.w400,
                        ),
                        const SizedBox(height: 20),
                        AppText.appText(
                          text1[index],
                          fontSize: 17,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                image.length,
                (index) => buildDot(index, context),
              ),
            ),
          
                image.length == 1 ?
                SizedBox(height: 60,): 
                SizedBox(height: 20,), 
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  children: [
                    AppButton.appButton(
                      radius: 28.0,
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      _currentPage == image.length - 1 ? "Get Started" : "Next",
                      onTap: () {
                        if (_currentPage == image.length - 1) {
                          push(context, Login());
                        } else {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        }
                      },
                    ),
                    _currentPage == image.length - 2
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: AppButton.appButton("Sign in", onTap: () {
                              push(context, Login());
                            },
                                radius: 28.0,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                backgroundColor: Colors.transparent,
                                borderColor: AppTheme.whiteColor),
                          ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 5),
      height: 10,
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        color: _currentPage == index ? AppTheme.appColor : Colors.grey,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
