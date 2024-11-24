import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../widgets/input_with_icon.dart'; // Make sure to import your IconInput widget

class Nutrition extends StatefulWidget {
  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  // Create TextEditingControllers for each field
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();
  final TextEditingController _controller4 = TextEditingController();

  String _apiResponse = "Response will appear here"; // Variable to hold the API response

  Future<void> sendDataToAPI(BuildContext context) async {
    final String carbs = _controller1.text;
    final String proteins = _controller2.text;
    final String lipids = _controller3.text;
    final String calories = _controller4.text;

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
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    _controller4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          padding: EdgeInsets.all(8.0), // Padding inside the container
          decoration: BoxDecoration(
            color: Colors.grey[200], // Background color for the container
            borderRadius: BorderRadius.circular(12.0), // Rounded corners
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Icon
              const CircleAvatar(
                radius: 20,
                backgroundColor: Colors.blue, // Background color for the icon
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.0), // Spacing between the icon and the chat bubble
              // Chat Bubble
              Flexible(
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white, // Chat bubble color
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  child: Text(
                    _apiResponse, // Display the API response here
                    style: TextStyle(color: Colors.black), // Text styling
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IconInput(
              icon: Icons.rice_bowl,
              label: 'Carbs',
              placeholder: 'Enter carbs amount',
              controller: _controller1,
            ),
            IconInput(
              icon: Icons.lunch_dining,
              label: 'Proteins',
              placeholder: 'Enter proteins amount',
              controller: _controller2,
            ),
            IconInput(
              icon: Icons.breakfast_dining,
              label: 'Lipids',
              placeholder: 'Enter lipids amount',
              controller: _controller3,
            ),
            IconInput(
              icon: Icons.whatshot,
              label: 'Calories',
              placeholder: 'Enter calories amount',
              controller: _controller4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendDataToAPI(context), // Pass context
        child: const Icon(Icons.sync),
      ),
    );
  }
}
