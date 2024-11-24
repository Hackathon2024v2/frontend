import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/settings.dart';
import 'package:flutter_application_2/widgets/profile_attribute.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';
import '../objects/User.dart';

final supabase = Supabase.instance.client;

class Profile extends StatelessWidget {
  final UserData user;
  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          "${user.first_name} ${user.last_name}",
          style: const TextStyle(
            color: Colors.white, // Red color
            fontStyle: FontStyle.italic, // Italic style
            fontSize: 24, // Optional: Adjust size
          ),
        ),
        elevation: 0,
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(LineAwesomeIcons.bars_solid),
            color: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Settings()),
              );
            },
          ),
        ],

      ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "${user.prefix} ${user.avatar}",
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 2,
                    child: Image(
                      image: AssetImage("assets/animals/${user.avatar}.gif"),
                      fit: BoxFit.contain
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileAttribute(label: "Age", value: "${DateTime.now().year - user.year} yo"),
                        const SizedBox(height: 10),
                        ProfileAttribute(label: "Weight", value: "${user.weight} kg"),
                        const SizedBox(height: 10),
                        ProfileAttribute(label: "Height", value: "${user.height} cm")
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 8),
                  Expanded(child: ProfileAttribute(label: "Score", value: "${user.score}")),
                ],
              ),
              const SizedBox(height: 16),
              // const Row(
              //   children: [
              //     Text("(user.score - user.previousLevelScore) / (user.nextLevelScore - user.previousLevelScore) * 100 }%"),
              //     SizedBox(width: 8),
              //     // /*Expanded(
              //     //   child:
              //     //   LinearProgressIndicator(
              //     //     value: (user.score - user.previousLevelScore) / (user.nextLevelScore - user.previousLevelScore),
              //     //   ),
              //     // ),*/
              //   ],
              // ),
              // /*
              // const SizedBox(height: 16),
              // ProfileAttribute(label: "Mood", value: user.emotion),
              // const SizedBox(height: 8),
              // ProfileAttribute(label: "Intelligence", value: user.intelligence),
              // const SizedBox(height: 8),
              // ProfileAttribute(label: "Goal", value: user.objective),
              // */
            ],
          ), 
        )
      ),
    );
  }

  bool isUserSignedIn() {
    final session = supabase.auth.currentSession;
    return session != null;
  }

}
