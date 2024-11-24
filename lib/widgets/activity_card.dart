import 'package:flutter/material.dart';
import '../main.dart';

class ActivityCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final double height; 
  final VoidCallback redirect; // Function parameter to handle redirection

  const ActivityCard({
    super.key,
    required this.icon,
    required this.label,
    required this.height,
    required this.redirect, // The function is required to be passed
  });

  @override
  _ActivityCardState createState() => _ActivityCardState();
}

class _ActivityCardState extends State<ActivityCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector( // Wrap the card with GestureDetector to detect taps
      onTap: widget.redirect, // Call the redirect function when the card is tapped
      child: Container(
        margin: const EdgeInsets.fromLTRB(0, 2, 2, 2), // Margin for the whole card
        padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
        height: widget.height,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Icon(widget.icon),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                widget.label,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
