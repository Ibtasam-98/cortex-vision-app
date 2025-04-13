import 'package:flutter/material.dart';



class DualToneText extends StatelessWidget {

  String firstText, secondText;
  Color firstTextColor, secondTextColor;
  final firstTextStyle, secondTextStyle;
  final firstTextFontWeight, secondTextFontWeight;
  final firstTextFontSize, secondTextFontSize;
  DualToneText({
    required this.firstText,
    required this.firstTextColor,
    required this.firstTextStyle,
    required this.secondText,
    required this.secondTextColor,
    required this.secondTextStyle,
    required this.firstTextFontWeight,
    required this.secondTextFontWeight,
    required this.firstTextFontSize,
    required this.secondTextFontSize,
  });
  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text:firstText,
          style: firstTextStyle(
            fontSize: firstTextFontSize,
            fontWeight: firstTextFontWeight,
            color:firstTextColor,
          ),
          children: [
            TextSpan(
              text: secondText,
              style: secondTextStyle(
                color: secondTextColor,
                fontSize: secondTextFontSize,
                fontWeight:secondTextFontWeight ,
              ),
            ),
          ]),
    );
  }
}
