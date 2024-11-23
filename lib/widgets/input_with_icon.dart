import 'package:flutter/material.dart';

class IconInput extends StatefulWidget {
  final IconData icon;
  final String label;
  final String placeholder;
  final TextEditingController controller;  // Add a controller

  IconInput({
    Key? key,
    required this.icon,
    required this.label,
    required this.placeholder,
    required this.controller,  // Pass controller as a parameter
  }) : super(key: key);

  @override
  _IconInputState createState() => _IconInputState();
}

class _IconInputState extends State<IconInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
      decoration: BoxDecoration(
        color: Colors.deepPurple[300],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(
            widget.icon,
          ),
          Text(
            widget.label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const Spacer(),
          Expanded(
            child: TextField(
              controller: widget.controller,  // Attach controller to the TextField
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(8.0),
                hintText: widget.placeholder,
                filled: true,
                fillColor: Colors.deepPurple[300],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              keyboardType: TextInputType.multiline,
            ),
          ),
          Text(
            'g',
          ),
        ],
      ),
    );
  }
}
