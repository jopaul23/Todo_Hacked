import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'Dropdown/dropdown.dart';

class TodoAddPageAppBar extends HookWidget {
  final Function() onBackButtonPressed;
  final Function(IconData) onSelected;
  final tagIcons = [
    Icons.work_rounded,
    Icons.local_taxi,
    Icons.home_rounded,
    Icons.fitness_center
  ];

  TodoAddPageAppBar({@required this.onBackButtonPressed, this.onSelected});
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    OverlayEntry dropDownOverlay;
    final tagIcon = useState(Icons.person);
    return Container(
      height: size.height * 0.098,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          boxShadow: [Styles.shadow()],
          gradient: Styles.t1Gradient,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                color: Styles.t1Orange.withOpacity(0.7),
                size: 40,
              ),
              onPressed: () {
                if (dropDownOverlay != null) dropDownOverlay.remove();
                onBackButtonPressed();
                Navigator.pop(context);
              }),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            child: SimpleAccountMenu(
              borderRadius: BorderRadius.circular(5),
              icons: tagIcons,
              iconColor: Colors.white,
              overlayAdded: (overlay) {
                dropDownOverlay = overlay;
              },
              onChange: (index) {
                tagIcon.value = tagIcons[index];
                onSelected(tagIcon.value);
              },
            ),
          ),
        ],
      ),
    );
  }
}
