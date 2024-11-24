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
  String selectedMuscle = 'All'; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Muscle Info"),
      ),
      body: Column(
        children: [
          // Muscle filter dropdown
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedMuscle,
              onChanged: (String? newValue) {
                setState(() {
                  selectedMuscle = newValue!;
                });
              },
              items: <String>[
                'All', 'Chest', 'Back', 'Shoulders', 'Legs', 'Arms', 'Core', 'Glutes', 'Traps'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
          // Exercise grid based on muscle type
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _exerciseStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No exercises available.'));
                }

                final exercises = snapshot.data!;
                final filteredExercises = selectedMuscle == 'All'
                    ? exercises
                    : exercises.where((exercise) {
                        final muscle = exercise['muscle'] ?? '';
                        return muscle == selectedMuscle;
                      }).toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredExercises.length,
                  itemBuilder: (context, index) {
                    final exercise = filteredExercises[index];
                    final exerciseName = exercise['name'] ?? 'Untitled';
                    final exerciseImg = exercise['exercise_img'] ?? 'Untitled';
                    final exerciseMuscle = exercise['muscle'] ?? 'Untitled';

                    return ExerciseCard(
                      exerciseName: exerciseName,
                      exerciseImg: exerciseImg,
                      exerciseMuscle: exerciseMuscle,
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
