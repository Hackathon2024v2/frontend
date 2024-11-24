import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';

class IconInput extends StatefulWidget {
  final IconData icon;
  final String label;
  final String placeholder;
  final TextEditingController controller;

  const IconInput({
    super.key,
    required this.icon,
    required this.label,
    required this.placeholder,
    required this.controller,
  });

  @override
  _IconInputState createState() => _IconInputState();
}

class _IconInputState extends State<IconInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(widget.icon),

          const SizedBox(width: 8),

          Expanded(
            child: Text(
              widget.label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              textAlign: TextAlign.left, // Optional: center-align text
            ),
          ),

          const SizedBox(width: 8),

          Expanded(
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: widget.controller,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                hintText: '0',
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
