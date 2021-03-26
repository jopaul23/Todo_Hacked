import 'package:Todo_App/Router/page_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';
import '../Themes/colors.dart' as appColors;

class BasicWidget extends StatelessWidget {
  final Widget child;
  final int pageNo;
  final Function() onFavClicked, onHomeClicked;
  const BasicWidget(
      {Key key, this.pageNo, this.child, this.onFavClicked, this.onHomeClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            child,
            Align(
              alignment: Alignment.bottomCenter,
              child: NavigationBar(
                onFavClicked: onFavClicked,
                onHomeClicked: onHomeClicked,
                pageNum: pageNo,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, right: 20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    PageRouter.sailor.navigate(PageRouter.todoAddPage);
                  },
                  child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                          color: theme.primaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [appColors.shadow]),
                      child: Icon(
                        Icons.add,
                        size: 50,
                        color: theme.accentColor,
                      )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
