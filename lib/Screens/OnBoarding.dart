// import 'package:chatbox/Controllers/GoogleAuth.dart';
// import 'package:chatbox/Utils/Colors.dart';
// import 'package:chatbox/Widgets.dart/ButtonWidget.dart';
// import 'package:chatbox/Widgets.dart/MyText.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class OnBoarding extends StatelessWidget {
//   final void Function()? onTap;
//   const OnBoarding({super.key,required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final maxHeight = MediaQuery.of(context).size.height;
//     return SafeArea(
//       child: Scaffold(
//         backgroundColor: ColorConstant.blackColor,
//         body: Container(
//           height: MediaQuery.of(context).size.height * 1.00,
//           width: double.infinity,
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//               image: AssetImage('assets/images/shadow.png'),
//               alignment: Alignment.topCenter,
//             ),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     SvgPicture.asset('assets/svg/C.svg'),
//                     const SizedBox(width: 3),
//                     MyText(
//                       myText: 'Chatbox',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       textColor: ColorConstant.whiteColor,
//                     ),
//                   ],
//                 ),
//                 MyText(
//                   myText: 'Connect friends easily & quickly',
//                   fontSize: maxHeight < 580 ? 36 : 60,
//                   fontWeight: FontWeight.w400,
//                   textColor: ColorConstant.whiteColor,
//                 ),
//                 MyText(
//                   myText:
//                       'Our chat app is the perfect way to stay connected with friends and family.',
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400,
//                   textColor: ColorConstant.textColor,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     // SvgPicture.asset('assets/svg/Facebook.svg'),
//                     Image.asset(
//                       'assets/images/emailWhite.png',
//                       height: 48,
//                       width: 48,
//                     ),
//                     const SizedBox(width: 16),
//                     GestureDetector(
//                         onTap: () {
//                           GoogleServices().signinWithGoogle(context);
//                         },
//                         child: SvgPicture.asset('assets/svg/Google.svg')),
//                     const SizedBox(width: 16),
//                     Image.asset(
//                       'assets/images/phoneWhite.png',
//                       height: 48,
//                       width: 48,
//                     ),
//                     // SvgPicture.asset('assets/svg/Apple.svg'),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Divider(
//                         color: ColorConstant.textColor,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 10,
//                       ),
//                       child: Text(
//                         'OR',
//                         style: GoogleFonts.carroisGothic(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w400,
//                           color: ColorConstant.textColor,
//                         ),
//                       ),
//                     ),
//                     Expanded(
//                       child: Divider(
//                         color: ColorConstant.textColor,
//                       ),
//                     ),
//                   ],
//                 ),
//                 ButtonWidget(
//                     buttonText: 'SignUp With Email',
//                     buttonColor: ColorConstant.greenColor,
//                     onTap: onTap),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
                    // MyText(
                    //   myText: 'Existing account?',
                    //   fontSize: 16,
                    //   fontWeight: FontWeight.w400,
                    //   textColor: ColorConstant.textColor,
                    // ),
//                     TextButton(
//                       onPressed: onTap,
//                       child: MyText(
//                         myText: 'Log In',
//                         fontSize: 16,
//                         fontWeight: FontWeight.w400,
//                         textColor: ColorConstant.greenColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
