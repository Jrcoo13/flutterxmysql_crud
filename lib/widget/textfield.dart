import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool isObscure;
  final TextEditingController controller;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.isObscure,
      required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        autofocus: true,
        autocorrect: false,
        controller: controller,
        obscureText: isObscure,
        obscuringCharacter: '*',
        decoration: InputDecoration(
            label: Text(
              hintText,
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(width: 1, color: Colors.grey.shade500)
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    BorderSide(width: 1.2, color: Colors.blue.shade400))),
      ),
    );
  }
}
