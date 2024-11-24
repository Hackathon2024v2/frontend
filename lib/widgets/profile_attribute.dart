import 'package:flutter/material.dart';

import '../main.dart';

class ProfileAttribute extends StatelessWidget {
  final String? label;
  final String value;

  const ProfileAttribute({super.key, this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Column(
          children: [
            if (label != null) Text(label ?? "", style: TextStyle(fontSize: 12, color: Colors.white)),
            Text(
              value,
              style: TextStyle(
                  fontSize: 18,
                color: Colors.white
              )
            ),
          ],
        ),
      ),
    );
  }
}
