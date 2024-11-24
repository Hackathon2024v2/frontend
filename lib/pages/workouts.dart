import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/exercise_page.dart';
import 'package:flutter_application_2/pages/info_gym.dart';
import 'package:flutter_application_2/pages/info_page.dart';
import 'package:flutter_application_2/widgets/workout_type_button.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../main.dart';
import '../widgets/activity_card.dart';

class Workouts extends StatefulWidget {
  const Workouts({super.key});

  @override
  State<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: const Text(
          'WORKOUTS',
          style: TextStyle(
            color: Colors.white, // Red color
            fontStyle: FontStyle.italic, // Italic style
            fontSize: 24, // Optional: Adjust size
          ),
        ),
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: Row(
                  children: [
                    WorkoutTypeButton(icon : 'assets/animals/gym.gif', title: 'GYM', destination: InfoGym()),
                    WorkoutTypeButton(icon : 'assets/animals/cardio.gif', title: 'CARDIO', destination: InfoGym()),
                  ],
                ),
              ),

              Center(
                child: Row(
                  children: [
                    WorkoutTypeButton(icon : 'assets/animals/hiking.gif', title: 'HIKING', destination: InfoGym()),
                    WorkoutTypeButton(icon : 'assets/animals/swimming.gif', title: 'SWIMMING', destination: InfoGym()),
                  ],
                ),
              ),

              Center(
                child: Row(
                  children: [
                    WorkoutTypeButton(icon : 'assets/animals/gyminfo.gif', title: 'GYM INFO', destination: InfoGym()),
                    const WorkoutTypeButton(icon : 'assets/animals/activities.gif', title: 'ACTIVITIES', destination: InfoPage(activity_type: "swimming")),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

