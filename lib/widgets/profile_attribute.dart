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
        color: color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Center(
        child: Column(
          children: [
            if (label != null) Text(label ?? "", style: const TextStyle(fontSize: 12, color: Colors.black)),
            Text(
              value,
              style: const TextStyle(
                  fontSize: 18,
                color: Colors.black
              )
            ),
          ],
        ),
      ),
    );
  }
}
