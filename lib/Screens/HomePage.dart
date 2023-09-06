import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:chatbox/Screens/Calls.dart';
import 'package:chatbox/Screens/Contacts.dart';
import 'package:chatbox/Screens/Message.dart';
import 'package:chatbox/Screens/Setting.dart';
import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Future<void> getUserData() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;

  // final User user = await auth.currentUser!;
  // final String? useremail = user.email;

  //   final DocumentSnapshot document = await FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(useremail)
  //       .get();
  //   final String fnames = document['userName'];
  //   final String femails = document['email'];
  //   final String fphones = document['phone'];
  //   final String furl = document['imageURL'];
  //   setState(() {
  //     name = fnames;
  //     email = femails;
  //     phone = fphones;
  //     images = furl;
  //     print('image urlss:::::  $userData["images"]');
  //     print('name :::::  $userData["name"]');
  //   });
  //   print(fnames);
  //   print(femails);
  //   print(furl);
  // }

  var _bottomNavIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const Message();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageStorage(bucket: bucket, child: currentScreen),
        floatingActionButton: FloatingActionButton(
          elevation: 0,
          onPressed: () {
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //       builder: (context) => const Chatpage(),
            //     ));
          },
          child: const Icon(Icons.chat_bubble),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 5,
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = const Message();
                          _bottomNavIndex = 0;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/Message.svg',
                            color: _bottomNavIndex == 0
                                ? ColorConstant.greenColor
                                : ColorConstant.greyColor.withOpacity(0.50),
                          ),
                          const SizedBox(height: 2),
                          MyText(
                            myText: 'Message',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: _bottomNavIndex == 0
                                ? ColorConstant.greenColor
                                : ColorConstant.greyColor.withOpacity(0.50),
                            letterspace: 1.0,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = const Calls();
                          _bottomNavIndex = 1;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/Call.svg',
                            color: _bottomNavIndex == 1
                                ? ColorConstant.greenColor
                                : ColorConstant.greyColor.withOpacity(0.50),
                          ),
                          const SizedBox(height: 2),
                          MyText(
                            myText: 'Calls',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: _bottomNavIndex == 1
                                ? ColorConstant.greenColor
                                : ColorConstant.greyColor.withOpacity(0.50),
                            letterspace: 1.0,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = const Contacts();
                          _bottomNavIndex = 2;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/Contacts.svg',
                            color: _bottomNavIndex == 2
                                ? ColorConstant.greenColor
                                : ColorConstant.greyColor.withOpacity(0.50),
                          ),
                          const SizedBox(height: 2),
                          MyText(
                            myText: 'Contacts',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: _bottomNavIndex == 2
                                ? ColorConstant.greenColor
                                : ColorConstant.greyColor.withOpacity(0.50),
                            letterspace: 1.0,
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      onPressed: () {
                        setState(() {
                          currentScreen = const Setting();
                          _bottomNavIndex = 3;
                        });
                      },
                      minWidth: 40,
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            'assets/svg/Settings.svg',
                            color: _bottomNavIndex == 3
                                ? ColorConstant.greenColor
                                : ColorConstant.greyColor.withOpacity(0.50),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Settings',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: _bottomNavIndex == 3
                                  ? ColorConstant.greenColor
                                  : ColorConstant.greyColor.withOpacity(0.50),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
