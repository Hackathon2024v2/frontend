import 'package:flutter/material.dart';
import 'package:flutter_application_2/widgets/ExerciseCard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class InfoPage extends StatefulWidget {
  final String activity_type;
  const InfoPage({required this.activity_type});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  final _activityStream =
      Supabase.instance.client.from('activities').stream(primaryKey: ['id']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Activity"),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _activityStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No activities available.'));
                }

                final activities = snapshot.data!;
                final filteredActivities = activities.where((activity) {
                  final type = activity['type'] ?? '';
                  return type == widget.activity_type;
                }).toList();

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: filteredActivities.length,
                  itemBuilder: (context, index) {
                    final activity = filteredActivities[index];
                    final activityName = activity['name'] ?? 'Untitled';
                    final activityImg = activity['activity_img'] ?? 'Untitled';
                    final activityType = activity['type'] ?? 'Untitled';

                    return ExerciseCard(
                      exerciseName: activityName,
                      exerciseImg: activityImg,
                      exerciseMuscle: activityType,
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
