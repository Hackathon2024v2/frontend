import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/exercise_page.dart';
import 'package:flutter_application_2/pages/info_gym.dart';
import 'package:flutter_application_2/pages/info_page.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../widgets/activity_card.dart';

class Workouts extends StatefulWidget {
  const Workouts({super.key});

  @override
  State<Workouts> createState() => _WorkoutsState();
}

class _WorkoutsState extends State<Workouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workouts'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Row for Gym + Plus button on the right
              Row(
                children: [
                  // Activity card
                  Expanded(
                    child: ActivityCard(
                      icon: LineAwesomeIcons.dumbbell_solid,
                      label: "Gym",
                      height: 50.0,
                      redirect: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => InfoGym(),
                          ),
                        );
                      },
                    ),
                  ),
                  // Container for the button, to match ActivityCard height
                  SizedBox(
                    height: 50.0, // Match height with ActivityCard
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ExerciseActivity(),
                        ));
                      },
                      child: const Icon(LineAwesomeIcons.plus_circle_solid),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.zero, // Remove padding to make it fit
                        backgroundColor: const Color.fromARGB(255, 138, 105, 82)
                            .withOpacity(0.5), // Customize button color
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                10), // No border radius on the right
                            bottomRight: Radius.circular(
                                10), // No border radius on the right
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Activity card
                  Expanded(
                    child: ActivityCard(
                      icon: LineAwesomeIcons.swimmer_solid,
                      label: "Swiming",
                      height: 50.0,
                      redirect: () {
                        print("Add new gym activity");
                      },
                    ),
                  ),
                  // Container for the button, to match ActivityCard height
                  SizedBox(
                    height: 50.0, // Match height with ActivityCard
                    child: ElevatedButton(
                      onPressed: () {
                        print("Add new gym activity");
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.zero, // Remove padding to make it fit
                        backgroundColor: const Color.fromARGB(255, 138, 105, 82)
                            .withOpacity(0.5), // Customize button color
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                10), // No border radius on the right
                            bottomRight: Radius.circular(
                                10), // No border radius on the right
                          ),
                        ),
                      ),
                      child: const Icon(LineAwesomeIcons.plus_circle_solid),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Activity card
                  Expanded(
                    child: ActivityCard(
                      icon: LineAwesomeIcons.hiking_solid,
                      label: "Hike",
                      height: 50.0,
                      redirect: () {},
                    ),
                  ),
                  // Container for the button, to match ActivityCard height
                  SizedBox(
                    height: 50.0, // Match height with ActivityCard
                    child: ElevatedButton(
                      onPressed: () {
                        print("Add new gym activity");
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.zero, // Remove padding to make it fit
                        backgroundColor: const Color.fromARGB(255, 138, 105, 82)
                            .withOpacity(0.5), // Customize button color
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                10), // No border radius on the right
                            bottomRight: Radius.circular(
                                10), // No border radius on the right
                          ),
                        ),
                      ),
                      child: const Icon(LineAwesomeIcons.plus_circle_solid),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  // Activity card
                  Expanded(
                    child: ActivityCard(
                      icon: LineAwesomeIcons.running_solid,
                      label: "Cardio",
                      height: 50.0,
                      redirect: () {
                        print("Add new gym activity");
                      },
                    ),
                  ),
                  // Container for the button, to match ActivityCard height
                  SizedBox(
                    height: 50.0, // Match height with ActivityCard
                    child: ElevatedButton(
                      onPressed: () {
                        print("Add new gym activity");
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.zero, // Remove padding to make it fit
                        backgroundColor: const Color.fromARGB(255, 138, 105, 82)
                            .withOpacity(0.5), // Customize button color
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(
                                10), // No border radius on the right
                            bottomRight: Radius.circular(
                                10), // No border radius on the right
                          ),
                        ),
                      ),
                      child: const Icon(LineAwesomeIcons.plus_circle_solid),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => InfoGym()));
                },
                child: const Text('Gym Info'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const InfoPage(activity_type: "swimming")));
                },
                child: const Text('Activity Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
