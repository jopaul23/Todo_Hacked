import 'package:todo_app/Router/page_router.dart';
import 'package:todo_app/styles/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Themes/colors.dart' as appColors;

class NavigationBar extends StatelessWidget {
  final int pageNum;
  final Function() onFavClicked, onHomeClicked;
  const NavigationBar(
      {@required this.pageNum, this.onFavClicked, this.onHomeClicked});
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return Container(
      height: 70,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: theme.accentColor,
          boxShadow: [appColors.shadow]),
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
