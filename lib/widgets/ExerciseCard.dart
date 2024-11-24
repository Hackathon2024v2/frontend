import 'package:flutter/material.dart';
import '../pages/info_page.dart';

class NoteCard extends StatelessWidget {
  final String title;
  final bool isDone;
  final ValueChanged<bool?> onChanged;
  final VoidCallback deleteNote;
  final String body;

  const NoteCard({
    super.key,
    required this.title,
    required this.isDone,
    required this.onChanged,
    required this.deleteNote,
    required this.body
  });

  @override
  Widget build(BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>  InfoNote(title: title, body:body)),
      );
    },
    child: Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.deepPurple[100],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isDone, 
                onChanged: onChanged,
                activeColor: Colors.deepPurple[800],
              ),
              Text(
                title,
              ),
              const Spacer(),
              IconButton(
                onPressed: deleteNote,
                icon: Icon(Icons.delete, color: Colors.grey[800]),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

}
