import 'package:flutter/material.dart';

class LeaderboardRows extends StatefulWidget {
  const LeaderboardRows({super.key});

  @override
  State<LeaderboardRows> createState() => _LeaderboardRowsState();
}

class _LeaderboardRowsState extends State<LeaderboardRows> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Text('Rang'),
        ),
        Container(
          child: Text('B'),
        )
      ],
    );
  }
}