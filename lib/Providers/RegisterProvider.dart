import 'dart:io';
import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Utils/localdata.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider with ChangeNotifier {
  bool isObscure = true;
  bool isObscure2 = true;
  bool isLoading = false;
  // String? downloadUrl;
  String uniqueName = DateTime.now().millisecondsSinceEpoch.toString();
  File? imagePicked;
  File? get image => imagePicked;

  // get image to user
  Future<void> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePicked = File(pickedFile.path);
      print('image path:: ${imagePicked}');
      notifyListeners();
    }
  }

  void obscureValue() {
    isObscure = !isObscure;
    notifyListeners();
  }

  void obscureValue2() {
    isObscure2 = !isObscure2;
    notifyListeners();
  }

  // signup with email & password
  void signupUser(
    context,
    username,
    email,
    phone,
    password,
    confirmPassword,
  ) async {
    isLoading = true;
    notifyListeners();
    try {
      if (password == confirmPassword) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final storage = FirebaseStorage.instance;
        final ref = storage.ref().child('images/$uniqueName');
        await ref.putFile(imagePicked!);
        String downloadUrl = await ref.getDownloadURL();
        saveDataFirebase(
          username,
          email,
          phone,
          password,
          confirmPassword,
          downloadUrl,
        );

        isLoading = false;
        notifyListeners();
      } else {
        showErrorMsg('password does not match');

        isLoading = false;
        notifyListeners();
      }
    } on FirebaseAuthException catch (e) {
    isLoading = false;
    notifyListeners();

      showErrorMsg(e.toString());
    }
  }

  // save data
  void saveDataFirebase(
    username,
    email,
    phone,
    password,
    confirmPassword,
    img,
  ) {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseFirestore.instance
        .collection('Users')
        .doc(auth.currentUser!.email)
        .set({
      'userName': username,
      'email': email,
      'phone': phone,
      'password': password,
      'confirm-password': confirmPassword,
      'imageURL': img,
      'uid': auth.currentUser!.uid,
    });
  }

  // get user data
  // Future<void> getUserData() async {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final User user = await auth.currentUser!;
  //   final String uid = user.uid;

  //   // Get the Firestore document for the current user.
  //   final DocumentSnapshot document =
  //       await FirebaseFirestore.instance.collection('Users').doc(uid).get();
  //   final String name = document['userName'];
  //   final String email = document['email'];
  //   final String url = document['imageURL'];
  //   imageUrl = url;
  //   notifyListeners();
  //   print(name);
  //   print(email);
  //   print(url);
  // }

  // show error msg
  void showErrorMsg(String msg) {
    ScaffoldMessenger(
      child: SnackBar(
        content: MyText(
          myText: msg,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textColor: ColorConstant.whiteColor,
        ),
        backgroundColor: Colors.red,
      ),
    );
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AlertDialog(
    //         backgroundColor: ColorConstant.textColor,
    //         title: Center(
    //           child: MyText(
    //             myText: msg,
    //             fontSize: 16,
    //             fontWeight: FontWeight.w500,
    //             textColor: ColorConstant.blackColor,
    //           ),
    //         ),
    //       );
    //     });
  }
}
