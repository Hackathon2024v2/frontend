import 'dart:math';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ExerciseActivity extends StatefulWidget {
  const ExerciseActivity({super.key});

  @override
  State<ExerciseActivity> createState() => _ExerciseActivityState();
}

class _ExerciseActivityState extends State<ExerciseActivity> {
  final int _duration = 20;
  final CountDownController _controller = CountDownController();
  Future<List<String>>? _imagesFuture;
  String? _randomImage; // Variable to store the random image URL

  @override
  void initState() {
    super.initState();
    _imagesFuture = fetchDataWithDynamicList();
  }

  Future<List<String>> fetchDataWithDynamicList() async {
    final supabase = Supabase.instance.client;

    try {
      final List<dynamic> response = await supabase
          .from('exercises')
          .select('exercise_img')
          .eq('muscle', 'Chest');

      final List<String> res =
          response.map((row) => row['exercise_img'] as String).toList();

      print(res); // Debugging
      return res;
    } catch (e) {
      print('Error fetching data: $e');
      return [];
    }
  }

  void pickRandomImage(List<String> images) {
    final random = Random();
    setState(() {
      _randomImage = images[random.nextInt(images.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Training Hard"),
      ),
      body: Column(
        children: [
          // Timer section within a container
          Container(
            // padding: const EdgeInsets.symmetric(vertical: 20),
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
              onComplete: () => debugPrint('Countdown Ended'),
              onChange: (String timeStamp) =>
                  debugPrint('Countdown Changed $timeStamp'),
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<String>>(
            future: _imagesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No images found."));
              }

              final images = snapshot.data!;
              // Ensure the random image is picked after the widget is built
              if (_randomImage == null) {
                // Using post-frame callback to set the random image after the first build
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  pickRandomImage(images);
                });
              }

              return Column(
                children: [
                  if (_randomImage != null)
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width *
                            0.5, // Adjust the width to be smaller
                        maxHeight: MediaQuery.of(context).size.height *
                            0.3, // Adjust the height to be smaller
                      ),
                      child: Image.network(
                        _randomImage!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  const SizedBox(height: 10), // Reduced space between timer and image
                  ElevatedButton(
                    onPressed: () => pickRandomImage(images),
                    child: const Text("Show Another Random Image"),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 20),
          // Timer control buttons, centered
          Align(
            alignment: Alignment.topCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _timerButton(
                  title: "Start",
                  onPressed: () {
                    _controller.start();
                  },
                ),
                const SizedBox(width: 10),
                _timerButton(
                  title: "Pause",
                  onPressed: () {
                    _controller.pause();
                    debugPrint("Pause ${_controller.isPaused}");
                  },
                ),
                const SizedBox(width: 10),
                _timerButton(
                  title: "Resume",
                  onPressed: () {
                    _controller.resume();
                    debugPrint("Resume ${_controller.isResumed}");
                  },
                ),
                const SizedBox(width: 10),
                _timerButton(
                  title: "Restart",
                  onPressed: () {
                    _controller.restart();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _timerButton({required String title, VoidCallback? onPressed}) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.purple),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
