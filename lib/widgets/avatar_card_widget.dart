import 'package:flutter/material.dart';

class CardButton extends StatelessWidget {
  final String imagePath;
  final String chosenImagePath;
  final Function(String) onImagePathChanged; // Callback function to update image path

  const CardButton({
    super.key,
    required this.imagePath,
    required this.chosenImagePath,
    required this.onImagePathChanged
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
          onImagePathChanged(imagePath); // Call the callback to update the image path in the parent
      },
      child: Container(
        width: 185,
        height: 185,
        decoration: BoxDecoration(
          color: imagePath == chosenImagePath ? Colors.red : Colors.white, // Change color based on isTapped
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Default shadow color
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // Offset for shadow
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Image.asset(
            imagePath, // Replace with your image asset path
            fit: BoxFit.cover,
            width: 145,
            height: 145,
          ),
        )
      ),
    );
  }
}
