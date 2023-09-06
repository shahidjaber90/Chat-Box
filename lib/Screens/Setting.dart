import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Utils/localdata.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:chatbox/Widgets.dart/TileWidet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.blackColor,
        body: Container(
            height: MediaQuery.of(context).size.height * 1.00,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: 0,
            ).copyWith(top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.logout,
                      color: ColorConstant.blackColor,
                    ),
                    MyText(
                      myText: 'Settings',
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      textColor: ColorConstant.whiteColor,
                      letterspace: 1.0,
                    ),
                    IconButton(
                      onPressed: () async {
                        final GoogleSignIn googleSignIn = GoogleSignIn();
                        await googleSignIn.signOut();
                        await FirebaseAuth.instance.signOut();
                        print('logout successfully');
                      },
                      icon: Icon(
                        Icons.logout,
                        color: ColorConstant.whiteColor,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 6)
                      .copyWith(top: 8),
                  decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 40,
                              child: Divider(
                                thickness: 3,
                              ),
                            )
                          ],
                        ),
                        ListTileWidget(
                          imageTile: NetworkImage(images),
                          titleText: MyText(
                            myText: name,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: ColorConstant.blackColor,
                            letterspace: 1.0,
                          ),
                          subTitleText: MyText(
                            myText: 'Never give up 💪',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.greyColor,
                            letterspace: 1.0,
                          ),
                          radiusVal: 28.0,
                          qrImage: SvgPicture.asset('assets/svg/QrCode.svg'),
                          badge: SizedBox(),
                        ),
                        const Divider(
                          height: 20,
                        ),
                        // account
                        ListTileWidget2(
                          imageTile: SvgPicture.asset('assets/svg/account.svg'),
                          titleText: MyText(
                            myText: 'Account',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: ColorConstant.blackColor,
                            letterspace: 1.0,
                          ),
                          subTitleText: MyText(
                            myText: 'Privacy, security, change number',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.greyColor,
                            letterspace: 1.0,
                          ),
                          radiusVal: 28.0,
                          qrImage: const SizedBox(),
                          badge: const SizedBox(),
                        ),
                        // Chat
                        ListTileWidget2(
                          imageTile:
                              SvgPicture.asset('assets/svg/Messages.svg'),
                          titleText: MyText(
                            myText: 'Chat',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: ColorConstant.blackColor,
                            letterspace: 1.0,
                          ),
                          subTitleText: MyText(
                            myText: 'Chat history,theme,wallpapers',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.greyColor,
                            letterspace: 1.0,
                          ),
                          radiusVal: 28.0,
                          qrImage: const SizedBox(),
                          badge: const SizedBox(),
                        ),
                        // Notifications
                        ListTileWidget2(
                          imageTile:
                              SvgPicture.asset('assets/svg/notifications.svg'),
                          titleText: MyText(
                            myText: 'Notifications',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: ColorConstant.blackColor,
                            letterspace: 1.0,
                          ),
                          subTitleText: MyText(
                            myText: 'Messages, group and others',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.greyColor,
                            letterspace: 1.0,
                          ),
                          radiusVal: 28.0,
                          qrImage: const SizedBox(),
                          badge: const SizedBox(),
                        ),
                        // Help
                        ListTileWidget2(
                          imageTile: SvgPicture.asset('assets/svg/help.svg'),
                          titleText: MyText(
                            myText: 'Help',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: ColorConstant.blackColor,
                            letterspace: 1.0,
                          ),
                          subTitleText: MyText(
                            myText: 'Help center,contact us, privacy policy',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.greyColor,
                            letterspace: 1.0,
                          ),
                          radiusVal: 28.0,
                          qrImage: const SizedBox(),
                          badge: const SizedBox(),
                        ),
                        // Storage and Data
                        ListTileWidget2(
                          imageTile: SvgPicture.asset('assets/svg/storage.svg'),
                          titleText: MyText(
                            myText: 'Storage and Data',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: ColorConstant.blackColor,
                            letterspace: 1.0,
                          ),
                          subTitleText: MyText(
                            myText: 'Network usage, stogare usage',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.greyColor,
                            letterspace: 1.0,
                          ),
                          radiusVal: 28.0,
                          qrImage: const SizedBox(),
                          badge: const SizedBox(),
                        ),
                        // Invite friend
                        ListTileWidget2(
                          imageTile: SvgPicture.asset('assets/svg/invite.svg'),
                          titleText: MyText(
                            myText: 'Invite a friend',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            textColor: ColorConstant.blackColor,
                            letterspace: 1.0,
                          ),
                          subTitleText: MyText(
                            myText: '',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            textColor: ColorConstant.greyColor,
                            letterspace: 1.0,
                          ),
                          radiusVal: 28.0,
                          qrImage: const SizedBox(),
                          badge: const SizedBox(),
                        ),
                        //
                      ],
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
