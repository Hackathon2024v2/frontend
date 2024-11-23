import 'package:flutter/material.dart';

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required String? Function(String?) validator,
  TextInputType? keyboardType = TextInputType.text,
  bool obscureText = false,
  IconButton? suffixIcon,
  String? labelText
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(5),
    ),
    child: TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 0.5),
          borderRadius: BorderRadius.circular(5),
        ),
        contentPadding: const EdgeInsets.only(left: 10),
        hintText: hintText,
        suffixIcon: suffixIcon,
        hintStyle: TextStyle(
          fontSize: 15,
          color: Colors.grey.withOpacity(0.7),
        ),
      ),
    ),
  );
}
