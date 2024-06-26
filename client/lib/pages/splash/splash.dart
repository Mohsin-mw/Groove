import 'package:groove/pages/splash/landing.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../utils/colors.dart';
import '../../utils/font_sizes.dart';

class Splash extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<Splash> {
  final controller = PageController(viewportFraction: 1.0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    final pages = [
      const Landing(
        title: "Gathered Streams Uniting the Viewers",
        description:
            "Join friends for synchronized streaming, enhancing the joy of collective viewing experiences.",
        imagePath: "images/LandingSplashOne.png",
      ),
      const Landing(
        title: "Streaming in Harmony Friends Together",
        description:
            "Enjoy streams with friends, synchronizing your viewing for a shared and enjoyable experience.",
        imagePath: "images/LandingSplashTwo.png",
      ),
      const Landing(
        title: "Unified Streaming Together with Friends",
        description:
            "Sync streams with friends, making watching together a blast in your app!",
        imagePath: "images/LandingSplashThree.png",
      )
    ];

    return Scaffold(
      backgroundColor: AppColors.accent,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height *
                    0.8, // Adjust the height as needed
                child: PageView.builder(
                  controller: controller,
                  itemCount: pages.length,
                  itemBuilder: (_, index) {
                    return pages[index];
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: pages.length,
                effect: const WormEffect(
                    dotHeight: 16,
                    dotWidth: 16,
                    type: WormType.normal,
                    activeDotColor: AppColors.primaryColor),
              ),
              const SizedBox(
                height: 20,
              ),
              _buildDivider(),
              _buildButtons(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildDivider() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.white.withOpacity(0.1),
      ),
    ),
  );
}

Widget _buildButtons(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              Navigator.pushNamed(context, '/authProvider');
            },
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 15.0,
              ),
              backgroundColor: AppColors.primaryColor,
            ),
            child: const Text(
              "Get Started",
              style: TextStyle(
                fontSize: AppTextStyles.textSizeMedium,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
