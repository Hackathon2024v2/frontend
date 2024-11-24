import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/profile_attribute.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text(
                      "Nom",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Attribut + type",
                      style: TextStyle(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  flex: 2,
                  child: Image(
                    image: AssetImage("assets/icons/gym.gif"),
                    fit: BoxFit.contain
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProfileAttribute(label: "Sexe", value: "Mâle"),
                      SizedBox(height: 10),
                      ProfileAttribute(label: "Âge", value: "22 ans"),
                      SizedBox(height: 10),
                      ProfileAttribute(label: "Poids", value: "50 kg"),
                      SizedBox(height: 10),
                      ProfileAttribute(label: "Taille", value: "1,76 m")
                    ],
                  ),
                ),
              ],
            ),
             ProfileAttribute(label: "Niveau", value: "16"),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(child: ProfileAttribute(label: "Niveau atteint", value: "12 000 pts")),
                SizedBox(width: 8),
                Expanded(child: ProfileAttribute(label: "XP actuel", value: "12 345 pts")),
                SizedBox(width: 8),
                Expanded(child: ProfileAttribute(label: "Prochain niveau", value: "16 000 pts"))
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Text("12%"),
                SizedBox(width: 8),
                Expanded(
                  child:
                    LinearProgressIndicator(
                      value: (12345 - 12000) / (16000 - 12000),
                    ),
                ),
              ],
            ),
            SizedBox(height: 16),
            ProfileAttribute(label: "État émotionnel", value: "Fâché"),
            SizedBox(height: 8),
            ProfileAttribute(label: "Intelligence", value: "Médiocre"),
            SizedBox(height: 8),
            ProfileAttribute(label: "Objectif", value: "Force / Masse musculaire"),
          ],
        ),
      ),
    );
  }
}
