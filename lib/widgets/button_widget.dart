import 'package:flutter/material.dart';

import '../main.dart';

Widget buttonStyle(String name, VoidCallback? onPressed) {
  return Container(
    height: 50,
    width: 300,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: color,
    ),
    child: TextButton(
        onPressed: onPressed,
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        )
    ),
  );
}