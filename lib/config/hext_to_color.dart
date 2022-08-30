import 'package:flutter/material.dart';

Color hexToColor(String code) {
  return  Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
}

Color hexToColor2(String hexString, {String alphaChannel = 'FF'}) {
  return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
}
/*
Let's assume you want to convert #000000 into a Color and have a 0.1 opacity on it. You can simply call this function like this:

hexToColor('#000000', alphaChannel: '1A');
And if you just call it like this:

hexToColor('#000000');*/
