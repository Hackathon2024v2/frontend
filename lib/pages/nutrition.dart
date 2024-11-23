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
      final responseText = response.body; // Get the response body
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Response: $responseText")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: ${response.statusCode} - ${response.body}")),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Request error: $e")),
    );
  }
}


  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    _controller3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nutrition Input')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            IconInput(
              icon: Icons.rice_bowl,
              label: ' Carbs',
              placeholder: 'Enter your email',
              controller: _controller1,
            ),
            IconInput(
              icon: Icons.lunch_dining,
              label: ' Proteins: ',
              placeholder: 'Enter your phone number',
              controller: _controller2,
            ),
            IconInput(
              icon: Icons.breakfast_dining,
              label: ' Lipids',
              placeholder: 'Enter your address',
              controller: _controller3,
            ),
            IconInput(
              icon: Icons.whatshot,
              label: ' calories',
              placeholder: 'Enter your address',
              controller: _controller4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => sendDataToAPI(context), // Pass context
        child: Icon(Icons.add),
      ),
    );
  }
}
