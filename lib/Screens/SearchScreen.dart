import 'package:chatbox/Providers/SearchProvider.dart';
import 'package:chatbox/Screens/ChatScreen.dart';
import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Utils/localdata.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:chatbox/Widgets.dart/TextFieldWidget.dart';
import 'package:chatbox/Widgets.dart/TileWidet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  String profileImage;
  SearchScreen({
    super.key,
    required this.profileImage,
  });

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic>? userMap;

  void onSearch() async {
    setState(() {
      isLoading = true;
    });
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await _firestore
        .collection('Users')
        .where('email', isEqualTo: searchController.text)
        .get()
        .then((value) {
      setState(() {
        userMap = value.docs[0].data();
      });
    });
    print('on search wala:: $userMap');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteColor,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          height: MediaQuery.of(context).size.height * 1.00,
          width: double.infinity,
          child: SingleChildScrollView(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: ColorConstant.blackColor,
                      )),
                  MyText(
                    myText: 'Search',
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    textColor: ColorConstant.blackColor,
                    letterspace: 1.0,
                  ),
                  FullScreenWidget(
                    backgroundColor: Colors.black,
                    backgroundIsTransparent: true,
                    disposeLevel: DisposeLevel.Medium,
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor:
                          ColorConstant.greenColor.withOpacity(0.25),
                      backgroundImage: NetworkImage(widget.profileImage),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: ColorConstant.chatColor,
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: SearchTextField(
                  hintText: 'Search user...',
                  controller: searchController,
                  onTap: () {
                    onSearch();
                  },
                ),
              ),
              isLoading
                  ? Container(
                      margin: const EdgeInsets.only(top: 50),
                      alignment: Alignment.center,
                      height: 100,
                      decoration: BoxDecoration(
                          color: ColorConstant.whiteColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: ColorConstant.chatColor,
                              blurRadius: 12,
                            )
                          ]),
                      child: ListTileWidget(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                userName: userMap!['userName'],
                                imageURL: userMap!['imageURL'],
                                userUid: userMap!['uid'],
                                userStatus: userMap!['status'],
                              ),
                            ),
                          );
                        },
                        imageTile: NetworkImage(userMap!['imageURL']),
                        titleText: MyText(
                          myText: userMap!['userName'].toUpperCase(),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          textColor: ColorConstant.blackColor,
                          letterspace: 1.0,
                        ),
                        subTitleText: MyText(
                          myText: userMap!['email'],
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
                              shape: BoxShape.circle, color: Color(0XFFF04A4C)),
                          child: MyText(
                            myText: userMap!['userName'].length.toString(),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            textColor: ColorConstant.whiteColor,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          )),
        ),
      ),
    );
  }
}
