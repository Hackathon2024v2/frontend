import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/leaderboard.dart';
import 'package:flutter_application_2/pages/nutrition.dart';
import 'package:flutter_application_2/pages/onboarding.dart';
import 'package:flutter_application_2/pages/profile.dart';
import 'package:flutter_application_2/pages/workouts.dart';
import 'package:flutter_application_2/pages/chat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    return userLoggedIn() == false ?
      Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text('Welcome !Username!'),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home), label: "Home"),
            NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
            NavigationDestination(icon: Icon(Icons.chat), label: "Chat"),
            NavigationDestination(icon: Icon(Icons.book), label: "Classement"),
            NavigationDestination(icon: Icon(Icons.breakfast_dining_outlined), label: "Nutrition")
          ],
        ),
       body:
        [
          const Workouts(),
          const Profile(),
          const Chat(),
          const Leaderboard(),
          Nutrition()
        ][currentPageIndex],
      )
      : const OnBoardingScreen();
  }
}

bool userLoggedIn() {
  final session = supabase.auth.currentSession;
  return session != null;
}
