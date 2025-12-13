import 'package:flutter/material.dart';

class CustomUserTextField extends StatelessWidget {
   CustomUserTextField({super.key, required this.controller, required this.labelText, this.textInputType});
  final TextEditingController controller ;
  final String labelText ;
  final TextInputType? textInputType ;


  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorHeight: 20,
      keyboardType: textInputType,
      cursorColor: Colors.white,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.white),
        ),
        labelText: labelText,
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}
