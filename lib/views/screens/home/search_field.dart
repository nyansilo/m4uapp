import 'package:flutter/material.dart';
import '../../../classes/language.dart';
import '../../../classes/language_constant.dart';

class SearchField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      child: GestureDetector(
        onTap: () {
          //showSearch(context: context, delegate: SearchProperties());
        },
        child: const AbsorbPointer(
          child: TextField(
            style: TextStyle(color: Colors.black, fontSize: 14.0),
            cursorColor: Colors.deepOrange,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 32.0, vertical: 14.0),
              suffixIcon: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  )),
              border: InputBorder.none,
              hintText: 'search_properties',
            ),
          ),
        ),
      ),
    );
  }
}
