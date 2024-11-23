import 'package:flutter/material.dart';


class InfoNote extends StatefulWidget {
  
  const InfoNote({super.key, required this.title, required this.body});
  

  final String title;
  final String body;

  @override
  State<InfoNote> createState() => _InfoNoteState();
}

class _InfoNoteState extends State<InfoNote> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Text(widget.body),
      )
    );
           
  }
}
