import 'package:flutter/material.dart';
import 'package:flutter_application_2/controllers/onboarding_controller.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../main.dart';
import '../widgets/onboarding_page.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoardingPage(
                  image: 'assets/icons/7kvp.gif',
                  title: 'Beast Mode Unleashed',
                  subtitle: "rack your daily streaks, stay consistent, and let your spirit animal push you toward your fitness goals."
              ),
              OnBoardingPage(
                  image: 'assets/icons/gym.gif',
                  title: 'Wild Streak Fitness',
                  subtitle: 'Keep the streak alive. Each day fuels your progress, with your animal companion cheering you on every step of the way.'
              ),
              OnBoardingPage(
                  image: 'assets/icons/n1567787.gif',
                  title: 'Your Workout Buddy',
                  subtitle: 'Stay motivated with your animal partner! Build streaks, crush workouts, and see your companion evolve as you conquer your goals.'
              ),
            ],
          ),

          const OnBoardingSkip(),

          const OnBoardingDotNavigation(),

          const OnBoardingNextButton()
        ],
      )
    );
  }
}

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24.0,
      bottom: kBottomNavigationBarHeight,
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(context),
        style: ElevatedButton.styleFrom(shape: const CircleBorder(), backgroundColor: color),
        child: const Icon(
            Iconsax.arrow_right_3,
        color: Colors.white)
      )
    );
  }
}

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
      bottom: kBottomNavigationBarHeight + 25,
      left: 24.0,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        onDotClicked: controller.dotNavigationClick,
        count: 3,
        effect: const ExpandingDotsEffect(
          activeDotColor: color,
          dotHeight: 6
        ),
      ),
    );
  }
}

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: kToolbarHeight,
      right: 24,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(context),
        style: TextButton.styleFrom(
          foregroundColor: color,
        ),
        child: const Text('skip')
      ),
    );
  }
}

