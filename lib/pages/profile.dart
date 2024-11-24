import 'package:flutter/material.dart';
import 'package:flutter_application_2/objects/ProfileUser.dart';
import 'package:flutter_application_2/widgets/profile_attribute.dart';

class Profile extends StatelessWidget {
  final ProfileUser user;
  const Profile({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        user.username,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${user.prefix} ${user.type}",
                        style: const TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Expanded(
                    flex: 2,
                    child: Image(
                        image: AssetImage("assets/icons/gym.gif"),
                        fit: BoxFit.contain
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProfileAttribute(label: "Sexe", value: user.sex),
                        const SizedBox(height: 10),
                        ProfileAttribute(label: "Âge", value: "${user.age} ans"),
                        const SizedBox(height: 10),
                        ProfileAttribute(label: "Poids", value: "${user.weight} kg"),
                        const SizedBox(height: 10),
                        ProfileAttribute(label: "Taille", value: "${user.height} m")
                      ],
                    ),
                  ),
                ],
              ),
              ProfileAttribute(label: "Niveau", value: user.level),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Expanded(child: ProfileAttribute(label: "Niveau atteint", value: "${user.previousLevelScore} pts")),
                  const SizedBox(width: 8),
                  Expanded(child: ProfileAttribute(label: "XP actuel", value: "${user.score}")),
                  const SizedBox(width: 8),
                  Expanded(child: ProfileAttribute(label: "Prochain niveau", value: "${user.nextLevelScore} pts"))
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Text("${(user.score - user.previousLevelScore) / (user.nextLevelScore - user.previousLevelScore) * 100 }%"),
                  const SizedBox(width: 8),
                  Expanded(
                    child:
                    LinearProgressIndicator(
                      value: (user.score - user.previousLevelScore) / (user.nextLevelScore - user.previousLevelScore),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProfileAttribute(label: "État émotionnel", value: user.emotion),
              const SizedBox(height: 8),
              ProfileAttribute(label: "Intelligence", value: user.intelligence),
              const SizedBox(height: 8),
              ProfileAttribute(label: "Objectif", value: user.objective),
            ],
          ),
        )
      ),
    );
  }
}
