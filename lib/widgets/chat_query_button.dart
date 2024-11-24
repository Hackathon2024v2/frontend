import 'package:flutter/material.dart';

class ChatQueryButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onPressed;

  const ChatQueryButton({super.key,
      required this.icon,
      required this.label,
      required this.value,
      required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColorLight,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 4),
                Text(label)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
