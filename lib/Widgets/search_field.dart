import 'package:flutter/material.dart';
import 'package:m_learning/constant/color.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextFormField(
        decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 30, // Adjust icon size
          ),
          suffixIcon: const Icon(
            Icons.mic,
            color: kPrimaryColor,
            size: 30, // Adjust icon size
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: "Search your topic",
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 16), // Adjust label font size
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30), // Adjust border radius
            borderSide: BorderSide.none,
          ),
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 7), // Adjust padding
        ),
      ),
    );
  }
}
