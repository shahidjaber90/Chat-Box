import 'package:chatbox/Utils/Colors.dart';
import 'package:flutter/material.dart';

class Calls extends StatelessWidget {
  const Calls({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height * 1.00,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Center(
            child: Text('Calls Page',style: TextStyle(fontSize: 60,color: ColorConstant.greenColor),),
          ),
        ),
      ),
    );
  }
}
