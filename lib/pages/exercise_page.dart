import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExerciseActivity extends StatefulWidget {
  const ExerciseActivity({super.key});

  @override
  State<ExerciseActivity> createState() => _ExerciseActivityState();
}

class _ExerciseActivityState extends State<ExerciseActivity> {
  final int _duration = 5;
  final CountDownController _controller = CountDownController();
  String? _randomImage;
  List<String> _remainingMuscles = [
    'Chest',
    'Back',
    'Shoulders',
    'Legs',
    'Arms',
    'Core',
    'Glutes',
    'Traps'
  ];
  bool _isComplete = false;
  int _currentScore = 0; // Variable to store the current score

  @override
  void initState() {
    super.initState();
    getCurrentPoints(); // Fetch the current score when the widget initializes
    showNextImage(); // Start the process when the widget initializes
  }

  // Fetch current score from Supabase
  void getCurrentPoints() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      debugPrint("No authenticated user.");
      return;
    }

    try {
      final response = await supabase
          .from('users')
          .select('score')
          .eq('user_uuid', userId)
          .single();

      setState(() {
        _currentScore = response['score'] ?? 0; // Default to 0 if score is not found
      });
    } catch (e) {
      debugPrint("Error fetching current score: $e");
    }
  }

  // Post the updated score (currentScore + 10)
  void postPoints() async {
    final supabase = Supabase.instance.client;
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      debugPrint("No authenticated user.");
      return;
    }

    try {
      await supabase
          .from('users')
          .update({
            'score': _currentScore + 10, // Update score by adding 10
          })
          .eq('user_uuid', userId);

      debugPrint("Points updated successfully for user: $userId");
      setState(() {
        _currentScore += 10; // Update local score to reflect change
      });
    } catch (e) {
      debugPrint("Error updating points: $e");
    }
  }

  // Show the next exercise image from Supabase
  void showNextImage() async {
    if (_remainingMuscles.isEmpty) {
      setState(() {
        _isComplete = true;
        _controller.pause(); // Pause the countdown when all exercises are done
      });
      return;
    }

    final nextMuscle = _remainingMuscles.removeAt(0); // Get the next muscle
    try {
      final supabase = Supabase.instance.client;
      final List<dynamic> response = await supabase
          .from('exercises')
          .select('exercise_img')
          .eq('muscle', nextMuscle);

      final List<String> newImages =
          response.map((row) => row['exercise_img'] as String).toList();

      if (newImages.isNotEmpty) {
        setState(() {
          _randomImage = newImages[0]; // Show the first image for the muscle
          _controller.restart(); // Restart the countdown timer
        });
      } else {
        debugPrint("No images found for muscle: $nextMuscle");
        setState(() {
          _randomImage = null;
        });
      }
    } catch (e) {
      debugPrint("Error fetching images: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Training Hard"),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: CircularCountDownTimer(
              duration: _duration,
              initialDuration: 0,
              controller: _controller,
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 4,
              ringColor: Colors.grey[300]!,
              fillColor: Colors.purpleAccent[100]!,
              backgroundColor: Colors.purple[500],
              strokeWidth: 20.0,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(
                fontSize: 33.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textFormat: CountdownTextFormat.S,
              isReverse: false,
              isReverseAnimation: false,
              isTimerTextShown: true,
              autoStart: true,
              onStart: () => debugPrint('Countdown Started'),
              onComplete: () => showNextImage(), // Show next image when timer completes
            ),
          ),
          const SizedBox(height: 10),
          if (_isComplete)
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Success! You've completed the exercise session!",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                ElevatedButton(
                  onPressed: postPoints,
                  child: const Text("Update Points"),
                ),
              ],
            )
          else if (_randomImage != null)
            Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.5,
                maxHeight: MediaQuery.of(context).size.height * 0.3,
              ),
              child: Image.network(
                _randomImage!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.broken_image, size: 50),
              ),
            )
          else
            const Center(child: Text("No image selected.")),
        ],
      ),
    );
  }
}
