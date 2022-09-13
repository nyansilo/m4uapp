import 'package:flutter/material.dart';
import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 0, left: 16, right: 16, bottom: 15),
        child: TextField(
          decoration: InputDecoration(
            hintText: translation(context).search_properties,
            hintStyle: TextStyle(color: Colors.grey.shade600),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            labelStyle: const TextStyle(fontSize: 12),
            contentPadding: const EdgeInsets.all(10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(20),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade100),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
        ));
  }
}
