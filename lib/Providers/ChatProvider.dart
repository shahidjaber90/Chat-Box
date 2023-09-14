import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatProvider with ChangeNotifier{
  //
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _fstore = FirebaseFirestore.instance;

  Future<void> sendMessege(String receiverid, String message) async {
    final String senderid = _auth.currentUser!.uid;

    List<String> ids = [senderid, receiverid];
    ids.sort();
    String chatroomid = ids.join('_');
    await _fstore
        .collection("ChatRoom")
        .doc(chatroomid)
        .collection("messeges")
        .add(
          {
        'senderId': senderid,
        'receiverId': receiverid,
        'text': message,
        'timestamp': FieldValue.serverTimestamp(),
      }
        );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMesseges(String userid,String otherid){
       List<String> ids = [userid, otherid];
       ids.sort();
       String chatRoomId = ids.join(('_'));
       return _fstore.collection("ChatRoom").doc(chatRoomId). collection('messeges').orderBy('timestamp',descending: false).snapshots();
  }
//
}

