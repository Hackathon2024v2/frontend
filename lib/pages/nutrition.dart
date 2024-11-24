import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../main.dart';
import '../widgets/input_with_icon.dart';

class Nutrition extends StatefulWidget {
  const Nutrition({super.key});

  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  // Create TextEditingControllers for each field
  final TextEditingController _carbsController = TextEditingController();
  final TextEditingController _proteinsController = TextEditingController();
  final TextEditingController _lipidsController = TextEditingController();
  final TextEditingController _caloriesController = TextEditingController();

  String _apiResponse = "Response will appear here"; // Variable to hold the API response

  Future<void> sendDataToAPI(BuildContext context) async {
    final String carbs = _carbsController.text.toString();
    final String proteins = _proteinsController.text.toString();
    final String lipids = _lipidsController.text.toString();
    final String calories = _caloriesController.text.toString();

    try {
      var url = Uri.parse('https://gpt-query-api.onrender.com/food');
      var response = await http.post(
        url,
        headers: {
          'Accept': 'application/json', // Accept header for JSON response
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "animal": "lion",
          "height": "1.82",
          "proteins": proteins,
          "lipids": lipids,
          "carbs": carbs,
          "calories": calories
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          _apiResponse = response.body; // Update the state with the API response
        });
      } else {
        setState(() {
          _apiResponse = "Error: ${response.statusCode} - ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _apiResponse = "Request error: $e";
      });
    }
  }

  @override
  void dispose() {
    _carbsController.dispose();
    _proteinsController.dispose();
    _lipidsController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background color
      appBar: AppBar(
        title: const Text(
          'NUTRITION GUIDE',
          style: TextStyle(
            color: Colors.white, // Red color
            fontStyle: FontStyle.italic, // Italic style
            fontSize: 24, // Optional: Adjust size
          ),
        ),
        centerTitle: true,
        backgroundColor: color,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IconInput(
              icon: LineAwesomeIcons.bread_slice_solid,
              label: 'Carbs',
              placeholder: 'Enter carbs amount',
              controller: _carbsController,
            ),
            IconInput(
              icon: LineAwesomeIcons.hamburger_solid,
              label: 'Proteins',
              placeholder: 'Enter proteins amount',
              controller: _proteinsController,
            ),
            IconInput(
              icon: LineAwesomeIcons.bacon_solid,
              label: 'Lipids',
              placeholder: 'Enter lipids amount',
              controller: _lipidsController,
            ),
            IconInput(
              icon: LineAwesomeIcons.fire_solid,
              label: 'Calories',
              placeholder: 'Enter calories amount',
              controller: _caloriesController,
            ),

            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.all(4.0),

              padding: const EdgeInsets.all(8.0), // Padding inside the container
              decoration: BoxDecoration(
                color: color.withOpacity(0.2), // Background color for the container
                borderRadius: BorderRadius.circular(12.0), // Rounded corners
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Profile Icon
                  const CircleAvatar(
                    radius: 20,
                    backgroundColor: color,
                    child: Icon(
                      LineAwesomeIcons.user_astronaut_solid,
                      color: Colors.white,
                    ),
                  ),

                  const SizedBox(width: 8.0),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Text(
                        _apiResponse,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: color,
        onPressed: () => sendDataToAPI(context), // Pass context
        child: const Icon(
          LineAwesomeIcons.sync_solid,
          color: Colors.white
        ),
      ),
    );
  }
}
