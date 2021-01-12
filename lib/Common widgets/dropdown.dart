import 'package:flutter/material.dart';
import 'package:Todo_App/styles/styles.dart';

class CustomDropdown extends StatefulWidget {
  final String text;

  const CustomDropdown({
    Key key,
    @required this.text,
  }) : super(key: key);

  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  double height, width, xPosition, yPosition, dropdownWidth = 170;
  bool isDropdownOpened = false;
  OverlayEntry floatingDropdown;
  GlobalKey actionKey;
  void initState() {
    actionKey = LabeledGlobalKey(widget.text);
    super.initState();
  }

  void findDropdownData() {
    RenderBox renderBox = actionKey.currentContext.findRenderObject();
    height = renderBox.size.height;
    width = renderBox.size.width;
    Offset offset = renderBox.localToGlobal(Offset.zero);
    xPosition = offset.dx;
    yPosition = offset.dy;
  }

  OverlayEntry _createFloatingdropdown() {
    return OverlayEntry(builder: (context) {
      return Positioned(
        left: xPosition - 15,
        width: dropdownWidth,
        top: yPosition + height,
        height: 400,
        child: DropDown(itemHeight: height),
      );
    });
  }

  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        if (isDropdownOpened) {
          floatingDropdown.remove();
        } else {
          findDropdownData();

          floatingDropdown = _createFloatingdropdown();
          Overlay.of(context).insert(floatingDropdown);
        }

        isDropdownOpened = !isDropdownOpened;
      },
      child: Container(
        width: dropdownWidth,
        height: 37,
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Styles.grey4.withOpacity(0.02),
              spreadRadius: 10,
              blurRadius: 7,
              offset: Offset(0, -1), // changes position of shadow
            ),
          ],
          color: Styles.white3.withOpacity(.8),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
        child: Row(
          children: [
            Text(
              "Catagories",
              style: TextStyle(
                  color: Styles.t1Orange,
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down_rounded,
              color: Styles.t1Orange,
              size: 35,
            )
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  final double itemHeight;
  const DropDown({Key key, @required this.itemHeight}) : super(key: key);
  Widget build(BuildContext context) {
    final double dropdownWidth = 140;
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Container(
          //color: Styles.t1Orange,
          width: dropdownWidth,
          child: Column(
            children: [
              DropDownItem.first(
                text: "Work",
                isSelected: false,
              ),
              DropDownItem(
                text: "Home",
                isSelected: true,
              ),
              DropDownItem.last(
                text: "College",
                isSelected: false,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DropDownItem extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;
  const DropDownItem(
      {Key key,
      this.text,
      this.isSelected = false,
      this.isFirstItem = false,
      this.isLastItem = false})
      : super(key: key);

  factory DropDownItem.first({String text, bool isSelected}) {
    return DropDownItem(
      text: text,
      isSelected: isSelected,
      isFirstItem: true,
      isLastItem: false,
    );
  }

  factory DropDownItem.last({String text, bool isSelected}) {
    return DropDownItem(
      text: text,
      isSelected: isSelected,
      isFirstItem: false,
      isLastItem: true,
    );
  }
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      height: 37,
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: isLastItem
            ? BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))
            : BorderRadius.horizontal(),
        boxShadow: [
          BoxShadow(
            color: Styles.grey4.withOpacity(0.02),
            spreadRadius: 10,
            blurRadius: 7,
            offset: Offset(0, -1), // changes position of shadow
          ),
        ],
        color: isSelected ? Styles.cream : Styles.white1.withOpacity(.8),
      ),
      child: Text(
        text,
        style: TextStyle(
            decoration: TextDecoration.none,
            color: Styles.t1Orange,
            fontWeight: FontWeight.w600,
            fontSize: 15),
      ),
    );
  }
}
