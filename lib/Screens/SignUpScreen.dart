import 'dart:io';
import 'package:chatbox/Providers/RegisterProvider.dart';
import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/ButtonWidget.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:chatbox/Widgets.dart/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class SignUpScreen extends StatelessWidget {
  final void Function()? onTap;
  const SignUpScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    TextEditingController userNameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController passswordController = TextEditingController();
    TextEditingController confirmPassswordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    File imageData;
    return SafeArea(
      child: Consumer<RegisterProvider>(
        builder: (context, value, child) => Scaffold(
          body: Form(
            key: _formKey,
            child: Container(
              height: MediaQuery.of(context).size.height * 1.00,
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_sharp,
                                color: ColorConstant.blackColor,
                              ))
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            myText: 'Log in to ',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            textColor: ColorConstant.blackColor,
                          ),
                          MyText(
                            myText: 'Chatbox',
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            textColor: ColorConstant.greenColor,
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      MyText(
                        myText:
                            'Get chatting with friends and family today by \nsigning up for our chat app!',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textColor: ColorConstant.blackColor,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      TextFieldWidget(
                        labelText: 'Your name',
                        prefixIcon: Icon(
                          Icons.person_2_outlined,
                          color: ColorConstant.greenColor,
                        ),
                        controller: userNameController,
                        isObscure: false,
                      ),
                      TextFieldWidget(
                        labelText: 'Your email',
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: ColorConstant.greenColor,
                        ),
                        controller: emailController,
                        isObscure: false,
                      ),
                      TextFieldWidget(
                        labelText: 'Phone',
                        prefixIcon: Icon(
                          Icons.call_outlined,
                          color: ColorConstant.greenColor,
                        ),
                        controller: phoneController,
                        isObscure: false,
                      ),
                      TextFieldWidget(
                        labelText: 'Password',
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          color: ColorConstant.greenColor,
                        ),
                        controller: passswordController,
                        isObscure: value.isObscure,
                        suffixIcon: IconButton(
                            onPressed: () {
                              value.obscureValue();
                            },
                            icon: value.isObscure
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: ColorConstant.greyColor,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: ColorConstant.greenColor,
                                  )),
                      ),
                      TextFieldWidget(
                        labelText: 'Confirm Password',
                        prefixIcon: Icon(
                          Icons.lock_open_outlined,
                          color: ColorConstant.greenColor,
                        ),
                        controller: confirmPassswordController,
                        isObscure: value.isObscure2,
                        suffixIcon: IconButton(
                            onPressed: () {
                              value.obscureValue2();
                            },
                            icon: value.isObscure2
                                ? Icon(
                                    Icons.visibility_off_outlined,
                                    color: ColorConstant.greyColor,
                                  )
                                : Icon(
                                    Icons.visibility_outlined,
                                    color: ColorConstant.greenColor,
                                  )),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // image text
                          Container(
                            alignment: Alignment.center,
                            height: 150,
                            width: 150,
                            child: MyText(
                              myText: 'Upload\nImage',
                              fontSize: 32,
                              fontWeight: FontWeight.w500,
                              textColor: ColorConstant.greenColor,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          // select image
                          GestureDetector(
                              onTap: () {
                                value.getImage();
                              },
                              child: value.imagePicked != null
                                  ? Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                              color: ColorConstant.blackColor
                                                  .withOpacity(0.20),
                                              blurRadius: 15,
                                              spreadRadius: 5,
                                              offset: const Offset(4, 4)),
                                        ],
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                            color: ColorConstant.whiteColor),
                                        color: ColorConstant.whiteColor,
                                        image: DecorationImage(
                                          image: FileImage(value.imagePicked!),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.whiteColor,
                                      ),
                                      child: SvgPicture.asset(
                                        'assets/images/pickImage.svg',
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                        ],
                      ),
                      //
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.06),
                      value.isLoading
                          ? LottieBuilder.asset(
                              'assets/lottie/loading.json',
                              height: 48,
                              width: 48,
                            )
                          : ButtonWidget(
                              buttonText: 'Create an account',
                              onTap: () {
                                if (phoneController.text.startsWith('+')) {
                                  value.signupUser(
                                    context,
                                    userNameController.text,
                                    emailController.text,
                                    phoneController.text,
                                    passswordController.text,
                                    confirmPassswordController.text,
                                  );
                                } else {
                                  value.showErrorMsg(
                                      'Please type phone Number with Country Code');
                                }
                              },
                              buttonColor: userNameController.text.isEmpty
                                  ? ColorConstant.greyColor.withOpacity(0.20)
                                  : emailController.text.isEmpty
                                      ? ColorConstant.greyColor
                                          .withOpacity(0.20)
                                      : passswordController.text.length < 8
                                          ? ColorConstant.greyColor
                                              .withOpacity(0.20)
                                          : confirmPassswordController
                                                      .text.length <
                                                  8
                                              ? ColorConstant.greyColor
                                                  .withOpacity(0.20)
                                              : ColorConstant.greenColor,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            myText: 'Existing account?',
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.textColor,
                          ),
                          TextButton(
                            onPressed: onTap,
                            child: MyText(
                              myText: 'Log In',
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              textColor: ColorConstant.greenColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
