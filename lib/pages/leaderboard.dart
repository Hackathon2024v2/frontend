import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'RANKING',
          style: TextStyle(
            color: Colors.white, // Red color
            fontStyle: FontStyle.italic, // Italic style
            fontSize: 24, // Optional: Adjust size
          ),
        ),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: ListView.separated(
          itemCount: users.length,
          padding: const EdgeInsets.all(10),
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 50,
              color: color.withOpacity(0.2),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Text('#${index+1}',
                        style: TextStyle(
                            fontSize: 35,
                            fontStyle: FontStyle.italic,
                            foreground: Paint()
                              ..style = PaintingStyle.stroke
                              ..strokeWidth = 2
                              ..color = Colors.blue
                        ),
                      ),
                      Text('#${index+1}',
                        style: const TextStyle(
                            fontSize: 35,
                            color: Colors.yellow,
                            fontStyle: FontStyle.italic
                        ),)
                    ],
                  ),
                  const SizedBox(width: 10,),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(20),
                      child: Image.network("https://play-lh.googleusercontent.com/0_kMh3ElxON8vTXO_bt2rpczk_KY_Kh65_HQNO-QVxz7GKbjvrljkIUWGI56YpsGGw=w240-h480-rw", fit: BoxFit.cover,),
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
      )
    );
  }
}