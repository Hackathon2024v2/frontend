import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/button_widget.dart';

enum ActivityType {
  swimming('Swimming', Colors.blue),
  exterior('Hiking', Colors.green),
  gym('Gym', Colors.grey),
  cardio('Cardio', Colors.red);

  const ActivityType(this.label, this.color);

  final String label;
  final Color color;
}

class LogActivity extends StatefulWidget {
  const LogActivity({super.key});

  @override
  State<LogActivity> createState() => _LogActivityState();
}

class _LogActivityState extends State<LogActivity> {
  final TextEditingController activityTypeController = TextEditingController();
  final TextEditingController activityDescriptionController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  ActivityType? selectedActivityType;

  Future<void> logNewActivity async {
    if (_formKey.currentState!.validate()) {

    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 24),
          // Quelle activité physique avez-vous fait?
          const Center(
              child: Text(
            "Quelle activité avez-vous fait?",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          )),
          const SizedBox(height: 12),
          // Activity category select menu
          DropdownMenu<ActivityType>(
            controller: activityTypeController,
            requestFocusOnTap: true,
            label: const Text("Type d'activité"),
            dropdownMenuEntries: ActivityType.values
                .map<DropdownMenuEntry<ActivityType>>((ActivityType entry) {
              return DropdownMenuEntry<ActivityType>(
                value: entry,
                label: entry.label,
                enabled: entry.label != 'Grey',
                style: MenuItemButton.styleFrom(
                  foregroundColor: entry.color,
                ),
              );
            }).toList(),
          ),
          // Précisions sur l'activité
          const SizedBox(height: 12),
          SizedBox(
              width: 250,
              child: TextField(
                controller: activityDescriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              )),
          const SizedBox(height: 12),
          // Multiplicateur actuel
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text("Points"),
                  Text("10",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
              Text("×",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              Column(
                children: [
                  Text("Streak de 4 jours"),
                  Text("1.4",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          const Column(
            children: [
              Text("Total"),
              Text("14 points",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          // Confirmer, annuler
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [buttonStyle(
                _isLoading? "en cours de traitement..." : "Confirmer", () {})],
          )
        ],
      ),
    );
  }
}
