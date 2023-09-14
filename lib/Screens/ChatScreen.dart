import 'package:chatbox/Providers/ChatProvider.dart';
import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:chatbox/Widgets.dart/TextFieldWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:full_screen_image/full_screen_image.dart';
import 'package:intl/intl.dart';
import 'package:speech_to_text/speech_to_text.dart' as speechToText;

class ChatScreen extends StatefulWidget {
  final String userName;
  final String imageURL;
  final String userUid;
  final String userStatus;
  const ChatScreen({
    super.key,
    required this.userName,
    required this.imageURL,
    required this.userUid,
    required this.userStatus,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String uids = '';
  String time = 'Just now';

  void setTime() {
    Future.delayed(Duration(seconds: 5));
    setState(() {
      
    });
  }

  speechToText.SpeechToText? speech;
  bool isSpeech = false;
  String speechText = '';

  void startListening() async {
    if (!isSpeech) {
      bool avail = await speech!.initialize(
        onStatus: (val) => print('status message: $val'),
        onError: (val) => print('error message: $val'),
      );
      if (avail) {
        setState(() {
          isSpeech = true;
        });
        speech!.listen(onResult: (val) {
          setState(() {
            speechText = val.recognizedWords;
            chatController.text = speechText;
            print('speechtext:::: $speechText');
          });
        });
      }
    } else {
      setState(() {
        isSpeech = false;
      });
      speech!.stop();
    }
  }

  @override
  void initState() {
    super.initState();
    speech = speechToText.SpeechToText();
  }

  // send messages
  void sendMessege() async {
    try {
      await ChatProvider().sendMessege(widget.userUid, chatController.text);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });

      chatController.clear();
    } catch (e) {
      print('Error:: ${e.toString()}');
    }
  }

  // get messages
  Stream<QuerySnapshot> _getChatMessages() {
    return FirebaseFirestore.instance
        .collection('messages')
        .where('senderId', isEqualTo: uids)
        .where('receiverId', isEqualTo: widget.userUid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteColor,
        appBar: AppBar(
          backgroundColor: ColorConstant.whiteColor,
          elevation: 0,
          toolbarHeight: 60,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                myText: widget.userName.toUpperCase(),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textColor: ColorConstant.blackColor,
                letterspace: 1.0,
              ),
              // const SizedBox(height: 2),
              MyText(
                myText: widget.userStatus,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textColor: ColorConstant.greenColor,
              ),
            ],
          ),
          leading: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: ColorConstant.blackColor,
                ),
              ),
              FullScreenWidget(
                backgroundColor: Colors.black,
                backgroundIsTransparent: true,
                disposeLevel: DisposeLevel.Medium,
                child: CircleAvatar(
                  radius: 24,
                  backgroundColor: ColorConstant.greenColor.withOpacity(0.25),
                  backgroundImage: NetworkImage(widget.imageURL),
                ),
              ),
            ],
          ),
          leadingWidth: 100,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Row(
                children: [
                  SvgPicture.asset('assets/svg/CallChat.svg'),
                  const SizedBox(width: 10),
                  SvgPicture.asset('assets/svg/video.svg'),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: StreamBuilder(
                    stream: ChatProvider()
                        .getMesseges(_auth.currentUser!.uid, widget.userUid),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Text('no messages yet..'),
                        );
                      } else {
                        final messages = snapshot.data!.docs;
                        List<Widget> messageWidgets = [];
                        for (var message in messages) {
                          final messageText = message['text'];
                          final timestamp = message['timestamp'];
                          final isSender = message['senderId'];
                          final messageWidget = MessageWidget(
                            messageText: messageText,
                            isSender: isSender,
                            timestamp: timestamp,
                          );
                          messageWidgets.add(messageWidget);
                        }

                        return ListView(
                          physics: const BouncingScrollPhysics(),
                          children: messageWidgets,
                        );
                      }
                    })),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }

  // start
  Widget _buildMessageComposer() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.10,
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/svg/Attachment.svg'),
              const SizedBox(width: 6),
              SizedBox(
                width: 216,
                height: MediaQuery.of(context).size.height * 0.08,
                child: ChatTextField(
                  hintText: 'Write your message',
                  controller: chatController,
                  onTap: () {
                    chatController.text.isEmpty ? null : sendMessege();
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              SvgPicture.asset('assets/svg/camera.svg'),
              const SizedBox(width: 15),
              GestureDetector(
                  onTap: startListening,
                  // onTap: () {
                  //   if (_isListening) {
                  //     _stopListening();
                  //   } else {
                  //     _startListening();
                  //   }
                  // },
                  child: SvgPicture.asset('assets/svg/microphone.svg')),
            ],
          ),
        ],
      ),
    );
  }
}

//

class MessageWidget extends StatelessWidget {
  final String messageText;
  final String isSender;
  final Timestamp timestamp;

  MessageWidget({
    required this.messageText,
    required this.isSender,
    required this.timestamp,
  });

  String _formatTimestamp(Timestamp timestamp) {
    final now = DateTime.now();
    final messageTime = timestamp.toDate();
    final difference = now.difference(messageTime);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, HH:mm').format(messageTime);
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    final messageBubble = Container(
      margin: isSender == _auth.currentUser!.uid
          ? const EdgeInsets.only(left: 80.0, top: 8.0, bottom: 8.0)
          : const EdgeInsets.only(right: 80.0, top: 8.0, bottom: 8.0),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: isSender == _auth.currentUser!.uid
            ? ColorConstant.greenColor
            : ColorConstant.chatColor,
        borderRadius: isSender == _auth.currentUser!.uid
            ? const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomLeft: Radius.circular(10.0),
              )
            : const BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 2 / 3.2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              messageText,
              style: TextStyle(fontSize: 15.0, color: ColorConstant.whiteColor),
            ),
            SizedBox(height: 4),
            Text(
              _formatTimestamp(timestamp),
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: ColorConstant.blackColor,
              ),
            ),
          ],
        ),
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: isSender == _auth.currentUser!.uid
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        children: [messageBubble],
      ),
    );
  }
}
