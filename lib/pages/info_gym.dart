import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../widgets/ExerciseCard.dart';

class InfoGym extends StatefulWidget {
  InfoGym({Key? key}) : super(key: key);

  @override
  _InfoGymState createState() => _InfoGymState();
}

class _InfoGymState extends State<InfoGym> {
    final _exerciseStream =
      Supabase.instance.client.from('exercises').stream(primaryKey: ['id']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Muscle Info"),
      ),
      body: Text('body')
    );
           
  }
}