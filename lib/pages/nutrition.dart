import 'package:flutter/material.dart';

import '../widgets/input_with_icon.dart';
  // Make sure to import your IconInput widget

class Nutrition extends StatefulWidget {
  @override
  _NutritionState createState() => _NutritionState();
}

class _NutritionState extends State<Nutrition> {
  // Create TextEditingControllers for each field
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final TextEditingController _controller3 = TextEditingController();

  // Function to get the data and send it to the API
  void sendDataToAPI() {
    final String data1 = _controller1.text;
    final String data2 = _controller2.text;
    final String data3 = _controller3.text;

    // Here you can call your API and pass the data
    print("Sending data: $data1, $data2, $data3");
    // API call logic goes here...
  }

  @override
  void dispose() {
    // Dispose of controllers to avoid memory leaks
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
              icon: Icons.email,
              label: 'Email',
              placeholder: 'Enter your email',
              controller: _controller1,  // Pass controller to the widget
            ),
            IconInput(
              icon: Icons.phone,
              label: 'Phone',
              placeholder: 'Enter your phone number',
              controller: _controller2,  // Pass controller to the widget
            ),
            IconInput(
              icon: Icons.location_on,
              label: 'Address',
              placeholder: 'Enter your address',
              controller: _controller3,  // Pass controller to the widget
            ),
            ElevatedButton(
              onPressed: sendDataToAPI,  // Call API function when the button is pressed
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
