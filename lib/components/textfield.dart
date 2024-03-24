import 'package:flutter/material.dart';


class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const MyTextField({super.key,
  required this.controller,
  required this.hintText,
  required this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 210, 181, 171)),
          borderRadius: BorderRadius.all(Radius.circular(10),),

        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 197, 169, 158)),
           ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle:TextStyle(
            color: Colors.grey[500],

          ) 
      ),
    );
  }
}