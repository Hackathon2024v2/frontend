import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_2/main.dart';
import 'package:flutter_application_2/pages/leaderboard.dart';
import 'package:flutter_application_2/pages/nutrition.dart';
import 'package:flutter_application_2/pages/onboarding.dart';
import 'package:flutter_application_2/pages/profile.dart';
import 'package:flutter_application_2/pages/workouts.dart';
import 'package:flutter_application_2/pages/chat.dart';
import 'package:iconsax/iconsax.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../objects/ProfileUser.dart';

final supabase = Supabase.instance.client;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  // TextEditingControllers to capture input from the dialog
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

    @override
  Widget build(BuildContext context) {
      SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        statusBarColor: color,
        statusBarIconBrightness: Brightness.dark,
      ));

    return userLoggedIn() == false ?
      Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: NavigationBar(
          height: 70,
          backgroundColor: color.withOpacity(0.2),
          indicatorColor: color.withOpacity(0.5),
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(icon: Icon(LineAwesomeIcons.home_solid), label: "Home"),
            NavigationDestination(icon: Icon(Iconsax.ranking), label: "Ranking"),
            NavigationDestination(icon: Icon(LineAwesomeIcons.hamburger_solid), label: "Nutrition"),
            NavigationDestination(icon: Icon(LineAwesomeIcons.comment_dots_solid), label: "Chat"),
            NavigationDestination(icon: Icon(LineAwesomeIcons.user), label: "Profile"),
          ],
        ),
       body:
        [
          const Workouts(),
          const Leaderboard(),
          const Nutrition(),
          const Chat(),
          Profile(user: userPlaceholder),
        ][currentPageIndex],
      )
      : const OnBoardingScreen();
  }
}

bool userLoggedIn() {
  final session = supabase.auth.currentSession;
  return session != null;
}
