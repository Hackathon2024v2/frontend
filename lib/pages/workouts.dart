import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_2/objects/User.dart';
import 'package:flutter_application_2/pages/info_gym.dart';

import 'log_activity.dart';

class Workouts extends StatefulWidget {
  const Workouts({super.key});

  @override
  State<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
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
                child: const Text(
                  'Streak: 4',
                  textAlign: TextAlign.center,
                ),
              )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => InfoGym()));
                  },
                  child: Text('gym info'))
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.directions_run),
          label: const Text("Ajouter une activité"),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return const LogActivity();
                });
          }),
    );
  }
}
