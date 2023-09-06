import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Utils/localdata.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:chatbox/Widgets.dart/TileWidet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:intl/intl.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  List badgecount = [1, 1, 1, 1, 1, 1];

  // get time
  String formatTimestamp(String timestamp) {
    final parsedTimestamp =
        DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final now = DateTime.now();
    final difference = now.difference(parsedTimestamp);

    if (difference.inMinutes < 1) {
      // Less than 1 minute, show seconds ago
      final secondsAgo = difference.inSeconds;
      return '$secondsAgo seconds ago';
    } else if (difference.inHours < 1) {
      // Less than 1 hour, show minutes ago
      final minutesAgo = difference.inMinutes;
      return '$minutesAgo minutes ago';
    } else if (difference.inDays == 0 && parsedTimestamp.day == now.day) {
      // Same day, show time in 24-hour format
      return DateFormat('jm').format(parsedTimestamp);
    } else if (difference.inDays < 7) {
      // Same day, show time in 24-hour format
      return DateFormat('EE').format(parsedTimestamp);
    } else {
      // Show date and day name in 24-hour format
      return DateFormat('d MMMM').format(parsedTimestamp);
    }
  }

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance.currentUser!;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.blackColor,
        body: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection('Users')
                .doc(auth.email)
                .snapshots(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child:
                        CircularProgressIndicator()); // Show a loading indicator while waiting
              } else if (snapshot.hasError) {
                return Center(child: Text('OOPs!: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data available'));
              } else {
                final userdataa = snapshot.data!.data() as Map<String, dynamic>;
                name = userdataa['userName'];
                email = userdataa['email'];
                phone = userdataa['phone'];
                images = userdataa['imageURL'];

                print('images datatata $images');

                print('user Data $userdataa');
                return Container(
                  height: MediaQuery.of(context).size.height * 1.00,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SvgPicture.asset('assets/svg/Search.svg'),
                                MyText(
                                  myText: 'Home',
                                  fontSize: 26,
                                  fontWeight: FontWeight.w500,
                                  textColor: ColorConstant.whiteColor,
                                  letterspace: 1.0,
                                ),
                                // MyText(
                                //   myText: 'Hello ${userdataa['userName']}👋',
                                //   fontSize: 16,
                                //   fontWeight: FontWeight.w500,
                                //   textColor: ColorConstant.greenColor,
                                // ),
                                FullScreenWidget(
                                  backgroundColor: Colors.black,
                                  backgroundIsTransparent: true,
                                  disposeLevel: DisposeLevel.Medium,
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: ColorConstant.greenColor
                                        .withOpacity(0.25),
                                    backgroundImage:
                                        NetworkImage(userdataa['imageURL']),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 12),
                              height: 60,
                              alignment: Alignment.topCenter,
                              child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 10,
                                itemBuilder: (context, index) {
                                  return FullScreenWidget(
                                    backgroundColor: ColorConstant.blackColor,
                                    disposeLevel: DisposeLevel.High,
                                    child: Container(
                                        height: 60,
                                        width: 60,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 6),
                                        padding: const EdgeInsets.all(3),
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color:
                                                    ColorConstant.greenColor),
                                            shape: BoxShape.circle
                                            // borderRadius: BorderRadius.circular(99),
                                            ),
                                        child: CircleAvatar(
                                          backgroundImage: NetworkImage(
                                              userdataa['imageURL']),
                                        )),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // chat screen
                      Container(
                        height: MediaQuery.of(context).size.height * 0.68,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 6)
                            .copyWith(top: 8),
                        decoration: BoxDecoration(
                            color: ColorConstant.whiteColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('Users')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.blue.shade800,
                                  ),
                                );
                              }

                              if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }

                              if (!snapshot.hasData ||
                                  snapshot.data!.docs.isEmpty) {
                                return const Text('No data available.');
                              }
                              final documentIds = snapshot.data!.docs;

                              return ListView.builder(
                                itemCount: documentIds.length,
                                itemBuilder: (context, index) {
                                  final info = documentIds[index].data()
                                      as Map<String, dynamic>;
                                  final usernames = info['userName'];
                                  final emails = info['email'];
                                  final imagess = info['imageURL'];
                                  return ListTileWidget(
                                    imageTile: NetworkImage(imagess),
                                    titleText: MyText(
                                      myText: usernames,
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
                                    qrImage: MyText(
                                      myText: '2 min ago',
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      textColor: ColorConstant.greyColor,
                                      letterspace: 1.0,
                                    ),
                                    badge: Container(
                                      alignment: Alignment.center,
                                      height: 24,
                                      width: 24,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0XFFF04A4C)),
                                      child: MyText(
                                        myText: badgecount.length.toString(),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        textColor: ColorConstant.whiteColor,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ],
                  ),
                );
              }
            }),
      ),
    );
  }
}
