import 'package:flutter/material.dart';
import 'package:flutter_application_2/main.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard(this.users, {super.key, });
  final List users;

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {


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
          itemCount: widget.users.length,
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
                  const SizedBox(width: 30,),
                  ClipOval(
                    child: SizedBox.fromSize(
                      size: Size.fromRadius(20),
                      child: Image.asset('assets/animals/${widget.users[index]['avatar']}.gif', color: Colors.white, colorBlendMode: BlendMode.multiply,),
                    ),
                  ),
                  const SizedBox(width: 75,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("${widget.users[index]['prefix'] ?? '' } ${widget.users[index]['first_name']} ${widget.users[index]['last_name']}", textAlign: TextAlign.center,),
                      Text("Score: ${widget.users[index]['score'] ?? '0'}", textAlign: TextAlign.center,)
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