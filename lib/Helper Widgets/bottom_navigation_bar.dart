import 'package:Todo_App/Router/page_router.dart';
import 'package:Todo_App/styles/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';

class NavigationBar extends StatelessWidget {
  final int pageNum;
  final Function() onFavClicked, onHomeClicked;
  const NavigationBar(
      {@required this.pageNum, this.onFavClicked, this.onHomeClicked});
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: 70,
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
          TextButton(
            onPressed: () {
              if (onHomeClicked != null) onHomeClicked();
              if (pageNum != 1) PageRouter.sailor.navigate(PageRouter.homePage);
            },
            child: Container(
              width: size.width / 4.5,
              child: Image(
                image: pageNum == 1
                    ? ImportedImages.homeOn
                    : ImportedImages.homeOff,
                height: 27,
                width: 27,
              ),
            ),
          ),
          TextButton(
            onPressed: onFavClicked,
            child: Container(
              width: size.width / 5.1,
              child: Image(
                image: pageNum == 2
                    ? ImportedImages.likedOn
                    : ImportedImages.likedOff,
                height: 27,
                width: 27,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (pageNum != 3)
                PageRouter.sailor.navigate(PageRouter.accountPage);
            },
            child: Container(
              width: size.width / 5.1,
              child: Image(
                image: pageNum == 3
                    ? ImportedImages.accountsOn
                    : ImportedImages.accountsOff,
                height: 27,
                width: 27,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
