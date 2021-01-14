import 'package:Todo_App/Router/page_router.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';

class BasicWidget extends StatelessWidget {
  final Widget child;
  final int pageNo;

  const BasicWidget({Key key, this.pageNo, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          child,
          Align(
            alignment: Alignment.bottomCenter,
            child: NavigationBar(
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
                        color: Styles.t1Orange,
                        shape: BoxShape.circle,
                        // borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Styles.grey1.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 20,
                          ),
                        ]),
                    child: Icon(
                      Icons.add,
                      color: Styles.white2,
                      size: 50,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
