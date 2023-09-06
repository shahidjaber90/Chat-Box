import 'package:chatbox/Utils/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  String buttonText;
  Color buttonColor;
  void Function()? onTap;
  ButtonWidget({
    super.key,
    required this.buttonText,
    required this.onTap,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: 60,
        width: double.infinity,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Text(
          buttonText,
          style: GoogleFonts.carroisGothic(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 1,
            color: ColorConstant.whiteColor,
          ),
        ),
      ),
    );
  }
}
