import 'package:chatbox/Screens/ChatScreen.dart';
import 'package:chatbox/Screens/SearchScreen.dart';
import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:chatbox/Widgets.dart/TileWidet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';

class Message extends StatefulWidget {
  const Message({super.key});

  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> with WidgetsBindingObserver {
  var auth = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController searchController = TextEditingController();
  List badgecount = [1, 1, 1, 1, 1, 1];
  Map<String, dynamic>? userMap;
  Map<String, dynamic>? userMap2;

  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus('Online');
  }

  void setStatus(String status) async {
    await _firestore.collection('Users').doc(auth.email).update({
      'status': status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (auth.uid == userMap!['uid']) {
      if (state == AppLifecycleState.resumed) {
        setStatus('Online');
      } else if (state == AppLifecycleState.hidden) {
        setStatus('Offline');
      } else {
        setStatus('Offline');
      }
    } else {
      setStatus('Offline');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('OOPs!: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return const Center(child: Text('No data available'));
              } else {
                userMap = snapshot.data!.data() as Map<String, dynamic>;
                // final userdataa = snapshot.data!.data() as Map<String, dynamic>;
                // name = userdataa['userName'];
                // email = userdataa['email'];
                // phone = userdataa['phone'];
                // images = userdataa['imageURL'];

                // print('images datatata $images');

                // print('user Map $userMap');
                return Container(
                  height: MediaQuery.of(context).size.height * 1.00,
                  width: double.infinity,
                  color: ColorConstant.blackColor,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SearchScreen(
                                              profileImage:
                                                  userMap!['imageURL'],
                                            ),
                                          ),
                                        );
                                      },
                                      child: SvgPicture.asset(
                                          'assets/svg/Search.svg')),
                                  MyText(
                                    myText: 'Home',
                                    fontSize: 26,
                                    fontWeight: FontWeight.w500,
                                    textColor: ColorConstant.whiteColor,
                                    letterspace: 1.0,
                                  ),
                                  FullScreenWidget(
                                    backgroundColor: Colors.black,
                                    backgroundIsTransparent: true,
                                    disposeLevel: DisposeLevel.Medium,
                                    child: CircleAvatar(
                                      radius: 24,
                                      backgroundColor: ColorConstant.greenColor
                                          .withOpacity(0.25),
                                      backgroundImage:
                                          NetworkImage(userMap!['imageURL']),
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
                                            shape: BoxShape.circle,
                                          ),
                                          child: CircleAvatar(
                                            backgroundImage: NetworkImage(
                                                userMap!['imageURL']),
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
                          height: MediaQuery.of(context).size.height * 0.71,
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
                                    userMap = documentIds[index].data()
                                        as Map<String, dynamic>;
                                    // final info = documentIds[index].data()
                                    //     as Map<String, dynamic>;
                                    final usernames = userMap!['userName'];
                                    final phone = userMap!['email'];
                                    final imagess = userMap!['imageURL'];
                                    final userUid = userMap!['uid'];
                                    final userStatus = userMap!['status'];
                                    if (userMap!['email'] !=
                                        FirebaseAuth
                                            .instance.currentUser!.email) {
                                      return ListTileWidget(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChatScreen(
                                                userName: usernames,
                                                imageURL: imagess,
                                                userUid: userUid,
                                                userStatus: userStatus,
                                              ),
                                            ),
                                          );
                                        },
                                        imageTile: NetworkImage(imagess),
                                        titleText: MyText(
                                          myText: usernames.toUpperCase(),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          textColor: ColorConstant.blackColor,
                                          letterspace: 1.0,
                                        ),
                                        subTitleText: MyText(
                                          myText: phone,
                                          // myText: 'Never give up 💪',
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
                                            myText: usernames.length.toString(),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            textColor: ColorConstant.whiteColor,
                                          ),
                                        ),
                                      );
                                    } else {
                                      return const SizedBox();
                                    }
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              }
            }),
      ),
    );
  }
}
