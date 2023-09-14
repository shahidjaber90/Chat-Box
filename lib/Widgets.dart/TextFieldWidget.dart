import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWidget extends StatelessWidget {
  String labelText;
  Icon prefixIcon;
  final controller;
  final suffixIcon;
  final isObscure;
  TextFieldWidget({
    super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.controller,
    this.suffixIcon,
    required this.isObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            myText: labelText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: ColorConstant.greenColor,
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            obscureText: isObscure,
            obscuringCharacter: '*',
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(12),
              ),
              prefixIcon: prefixIcon,
              filled: true,
              fillColor: ColorConstant.greyColor.withOpacity(0.10),
              suffixIcon: suffixIcon,
            ),
          ),
        ],
      ),
    );
  }
}

// chat textfield

class ChatTextField extends StatelessWidget {
  String hintText;
  final controller;
  final suffixIcon;
  void Function()? onTap;
  ChatTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.suffixIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.carroisGothic(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ColorConstant.greyColor,
          letterSpacing: 0.5,
        ),
        filled: true,
        fillColor: ColorConstant.greyColor.withOpacity(0.10),
        suffixIcon: IconButton(
          onPressed: onTap,
          icon: Icon(
            Icons.send,
            color: ColorConstant.blackColor.withOpacity(0.50),
          ),
        ),
      ),
    );
  }
}

// Search textfield

class SearchTextField extends StatelessWidget {
  String hintText;
  TextEditingController controller;
  void Function()? onTap;
  SearchTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(12),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.carroisGothic(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: ColorConstant.greyColor,
          letterSpacing: 0.5,
        ),
        filled: true,
        fillColor: ColorConstant.whiteColor,
        suffixIcon: IconButton(
          onPressed: () {
            controller.clear();
          },
          icon: Icon(
            Icons.close,
            color: ColorConstant.blackColor.withOpacity(0.50),
          ),
        ),
      ),
      onEditingComplete: onTap,
    );
  }
}
