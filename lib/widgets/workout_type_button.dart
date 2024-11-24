import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';

import '../pages/info_gym.dart';

class WorkoutTypeButton extends StatelessWidget {
  final String icon;
  final String title;
  final Widget destination;

  const WorkoutTypeButton({
    super.key,
    required this.icon, // Properly initialize the 'icon' parameter
    required this.title,
    required this.destination, // Properly initialize the 'onPressed' parameter
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination), // Navigate to destination
        );
      },
      child: Container(
          width: MediaQuery.of(context).size.width * 0.41,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(8),
          child: Column(
              children: [
                Image.asset(
                  icon,
                ),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                    color: color,
                  ),
                ),
              ]
          )
      ),
    );
  }
}
