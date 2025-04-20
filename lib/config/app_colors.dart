
import 'dart:math';

import 'package:flutter/material.dart';


// Define app color constants for consistency and reusability

const whiteColor = Colors.white;
const blackColor = Colors.black;
const grey = Colors.grey;
const primaryColor = Color(0xff092A6E);
const secondryColor = Color(0xff0d40a6);
const tertaryColor = Color(0xff000D28);
const facebookColor = Color(0xff0c4391);
const googleColor = Color(0xffDB4437);
const appleColor = Color(0xffDB4437);
const yellowColor = Colors.yellow;
const greenColor = Color(0xff5cb85c);
const lightGreen = Color(0xff6ded8f);
const redDarkShade = Color(0xff8c0303);
const transparent = Colors.transparent;
const lightgray = Color(0xFFEBEBED);
const red = Color(0xffcc0610);
const primaryColorOpacity = Color(0xffbed2fa);

Color randomColor() {
  final Random random = Random();
  return Color.fromARGB(
    255,
    random.nextInt(256),
    random.nextInt(256),
    random.nextInt(256),
  );
}

