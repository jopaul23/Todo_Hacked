import 'package:Todo_App/styles/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final int pageNum;
  const NavigationBar({@required this.pageNum});
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        color: Styles.white2,
        boxShadow: [
          BoxShadow(
            color: Styles.grey4.withOpacity(0.02),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: size.width / 4.15,
            child: Image(
              image:
                  pageNum == 1 ? ImportedImages.homeOn : ImportedImages.homeOff,
              height: 32,
              width: 32,
            ),
          ),
          Container(
            width: size.width / 4.15,
            child: Image(
              image: pageNum == 2
                  ? ImportedImages.likedOn
                  : ImportedImages.likedOff,
              height: 32,
              width: 32,
            ),
          ),
          Container(
            width: size.width / 4.15,
            child: Image(
              image: pageNum == 3
                  ? ImportedImages.accountsOn
                  : ImportedImages.accountsOff,
              height: 32,
              width: 32,
            ),
          ),
        ],
      ),
    );
  }
}
