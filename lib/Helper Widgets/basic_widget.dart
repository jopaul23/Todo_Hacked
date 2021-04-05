import 'package:todo_app/TodoAddPage/Widgets/addpage_layout.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../Themes/colors.dart' as appColors;

class BasicWidget extends StatelessWidget {
  final Widget child;
  const BasicWidget({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            child,
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0, right: 20.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    addPage(context);
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

  void addPage(context) {
    OverlayEntry entry;

    entry = OverlayEntry(
        builder: (context) => AddPageLayout(
              entry: entry,
              size: MediaQuery.of(context).size,
            ));
    Overlay.of(context).insert(entry);
  }
}
