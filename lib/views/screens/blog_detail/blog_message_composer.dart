import 'package:flutter/material.dart';

import '../../../config/config.dart';
import '../../../utils/utils.dart';

class BlogMessageComposer extends StatelessWidget {
  final blog;
  BlogMessageComposer({this.blog});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            padding:
                const EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 10),
            height: 60,
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.lightBlue,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: CircleAvatar(
                      radius: 24.0,
                      backgroundImage: AssetImage(ImageString.defaultImage),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Write Comment...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      //border: InputBorder.none,
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
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: 40,
                  height: 40,
                  child: FittedBox(
                    child: FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 24,
                      ),
                      backgroundColor: brandingColor,
                      elevation: 0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
