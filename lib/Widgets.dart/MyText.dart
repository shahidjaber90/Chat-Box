import 'package:chatbox/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  String myText;
  double fontSize;
  FontWeight fontWeight;
  Color textColor;
  final textAlign;
  final letterspace;
  MyText({
    super.key,
    required this.myText,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    this.textAlign,
    this.letterspace,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      myText,textAlign: textAlign,
      style: GoogleFonts.carroisGothic(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: textColor,
        letterSpacing: letterspace,
      ),
    );
  }
}
