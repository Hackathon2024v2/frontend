import 'package:flutter/material.dart';
import 'package:flutter_application_2/objects/User.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  List<User> users = [
    User(username: "Mathieu", prefix: "Swimming", height: 5.20, score: 1000),
    User(username: "Alex", prefix: "", height: 5.20, score: 1002),
    User(username: "Nathan", prefix: "Flying", height:  5.20, score: 1003),
    User(username: "Samy", prefix: "", height: 5.20, score: 10011),
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: users.length,
      padding: const EdgeInsets.all(5),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          color: Colors.red,
          child: Row(
            children: [
              Stack(
                children: [
                  Text('#$index',
                  style: TextStyle(
                    fontSize: 35,
                    fontStyle: FontStyle.italic,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.blue
                  ),)
                ],
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: Size.fromRadius(40),
                  child: Placeholder(),
                ),
              ),
              const SizedBox(width: 75,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("${users[index].prefix} ${users[index].username}"),
                  Text("Score: ${users[index].score}")
                ],
              )
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider()
    );
  }
}