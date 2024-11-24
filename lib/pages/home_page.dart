import 'dart:convert';

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

import '../objects/User.dart';

final supabase = Supabase.instance.client;

Future<List> getLeaderboardData() async {
  final response = await supabase.from('users').select().order('score', ascending: false);
  final List data = response;
  return data;
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPageIndex = 0;

  

  late Future<List> _futureLeaderboard;
  
  @override
  void initState(){
    super.initState();
    _futureLeaderboard = getLeaderboardData();
  }
  

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
    return userLoggedIn() == true ?
    FutureBuilder(future: _futureLeaderboard, builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      if (snapshot.hasError){
        return Center(
          child: Text('${snapshot.error}'),
        );
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty){
        return const OnBoardingScreen();
      }

      List usersData = snapshot.data!;

      return Scaffold(
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
          Leaderboard(usersData),
          const Nutrition(),
          const Chat(),
          Profile(user: UserData.fromMetadata(supabase.auth.currentSession!.user.userMetadata)),
        ][currentPageIndex],
      );
    })
      
      : const OnBoardingScreen();
  }

  bool userLoggedIn() {
    final session = supabase.auth.currentSession;
    return session != null;
  }
}

