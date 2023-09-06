import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  final imageTile;
  Widget titleText;
  Widget subTitleText;
  final qrImage;
  final badge;
  double radiusVal;
  ListTileWidget({
    super.key,
    required this.imageTile,
    required this.titleText,
    required this.subTitleText,
    this.qrImage,
    required this.radiusVal,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        backgroundImage: imageTile,
        radius: radiusVal,
      ),
      title: titleText,
      subtitle: subTitleText,
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          qrImage,
          const SizedBox(height: 4),
          badge,
        ],
      ),
    );
  }
}

class ListTileWidget2 extends StatelessWidget {
  final imageTile;
  Widget titleText;
  Widget subTitleText;
  final qrImage;
  double radiusVal;
  final badge;
  ListTileWidget2({
    super.key,
    required this.imageTile,
    required this.titleText,
    required this.subTitleText,
    this.qrImage,
    required this.radiusVal,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: ListTile(
        leading: ClipRRect(
          child: imageTile,
        ),
        title: titleText,
        subtitle: subTitleText,
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            qrImage,
            badge,
          ],
        ),
      ),
    );
  }
}
