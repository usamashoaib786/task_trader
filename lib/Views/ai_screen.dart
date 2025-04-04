import 'package:flutter/material.dart';
import 'package:task_trader/Resources/app_bar.dart';
import 'package:task_trader/Resources/app_text.dart';
import 'package:task_trader/Resources/app_theme.dart';
import 'package:task_trader/Resources/images.dart';
import 'package:task_trader/Resources/quotes.dart';

class AiPowered extends StatefulWidget {
  const AiPowered({super.key});

  @override
  State<AiPowered> createState() => _AiPoweredState();
}

class _AiPoweredState extends State<AiPowered>
    with SingleTickerProviderStateMixin {
  late String randomQuote;
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    randomQuote = QuoteProvider.getRandomQuote();

    // Delay the animation to start after 300ms
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomAppBar(
        leadingIcon: Images.backIconBlack,
        title: "AI Powered",
        fontsize: 20,
        fontWeight: FontWeight.w600,
        color: AppTheme.white,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppText.appText("AI Coach:",
                textColor: AppTheme.white,
                fontSize: 24,
                fontWeight: FontWeight.w700),
            const SizedBox(height: 10),
            AppText.appText("Stay Disciplined!",
                textColor: AppTheme.white,
                fontSize: 20,
                fontWeight: FontWeight.w400),
            const SizedBox(height: 30),

            // Animated Quote Box
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: _opacity,
              curve: Curves.easeInOut,
              child: Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.white12,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppTheme.appColor.withValues(alpha: 0.6)),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.format_quote,
                        color: Colors.cyan, size: 30),
                    const SizedBox(height: 10),
                    Text(
                      '"$randomQuote"',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}

            // Inspire Me Again Button
            // ElevatedButton(
            //   onPressed: () {
            //     setState(() {
            //       randomQuote = QuoteProvider.getRandomQuote();
            //     });
            //   },
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: AppTheme.appColor,
            //     shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12)),
            //     padding:
            //         const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            //     textStyle:
            //         const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            //   ),
            //   child: const Text("Inspire Me Again"),
            // ),
   // SizedBox(
              //   width: 350,
              //   child: Column(
              //     children: [
              //       AppButton.appButton("Play Audio",
              //           width: ScreenSize(context).width,
              //           height: 62,
              //           radius: 28.0,
              //           fontSize: 20,
              //           fontWeight: FontWeight.w400),
              //       SizedBox(
              //         height: 20,
              //       ),
              //       AppButton.appButton("Continue",
              //           width: ScreenSize(context).width,
              //           height: 62,
              //           radius: 28.0,
              //           fontSize: 20,
              //           fontWeight: FontWeight.w400),
              //       SizedBox(
              //         height: 20,
              //       ),
              //     ],
              //   ),
              // )
           