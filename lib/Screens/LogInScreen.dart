import 'package:chatbox/Providers/LoginProvider.dart';
import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/ButtonWidget.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:chatbox/Widgets.dart/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  final void Function()? onTap;
  const LogInScreen({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passswordController = TextEditingController();
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    return SafeArea(
      child: Consumer<LoginProvider>(
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
                            'Welcome back! Sign in using your social \naccount or email to continue us',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        textColor: ColorConstant.blackColor,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // SvgPicture.asset('assets/svg/FacebookWhite.svg'),
                          Image.asset(
                            'assets/images/emailBlack.png',
                            height: 48,
                            width: 48,
                          ),
                          const SizedBox(width: 16),
                          SvgPicture.asset('assets/svg/GoogleWhite.svg'),
                          const SizedBox(width: 16),
                          Image.asset(
                            'assets/images/phoneBlack.jpg',
                            height: 56,
                            width: 56,
                          ),
                          // SvgPicture.asset('assets/svg/appleWhite.svg'),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: ColorConstant.textColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            child: Text(
                              'OR',
                              style: GoogleFonts.carroisGothic(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: ColorConstant.textColor,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: ColorConstant.textColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
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
                      //
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18),
                      value.isLoading
                          ? LottieBuilder.asset('assets/lottie/loading.json',height: 48,width: 48,)
                          : ButtonWidget(
                              buttonText: 'Log In',
                              onTap: () {
                                value.signinUser(
                                  context,
                                  emailController.text,
                                  passswordController.text,
                                );
                                emailController.clear();
                                passswordController.clear();
                              },
                              buttonColor: emailController.text.isEmpty
                                  ? ColorConstant.greyColor.withOpacity(0.20)
                                  : passswordController.text.length < 8
                                      ? ColorConstant.greyColor
                                          .withOpacity(0.20)
                                      : ColorConstant.greenColor,
                            ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MyText(
                            myText: "Don't have an account?",
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.textColor,
                          ),
                          TextButton(
                            onPressed: onTap,
                            child: MyText(
                              myText: 'Sign Up',
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
