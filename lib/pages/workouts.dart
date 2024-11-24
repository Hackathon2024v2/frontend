import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/objects/User.dart';
import 'package:flutter_application_2/pages/info_gym.dart';

class Workouts extends StatefulWidget {
  const Workouts({super.key});

  @override
  State<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  User userRaw =
      User(username: "Chill guy", prefix: "Just a ", height: 6.20, score: 900);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: Container(
              color: Colors.amber,
              child: Text(
                'Streak: 4',
                textAlign: TextAlign.center,
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => InfoGym()));
                },
                child: Text('gym info'))
          ],
        ),
      ],
    ));
  }
}
