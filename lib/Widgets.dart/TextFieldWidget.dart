import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:flutter/material.dart';

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
