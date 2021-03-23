import 'package:flutter/material.dart';

class AddTitle extends StatelessWidget {
  final TextEditingController controller;

  const AddTitle({Key key, @required this.controller}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
      height: size.height * 0.06,
      child: TextField(
        autofocus: true,
        controller: controller,
        cursorHeight: 40,
        onChanged: (String val) {
          if (val.length > 15) {
            controller.text = controller.text.substring(0, 15);

            controller.selection = TextSelection.fromPosition(
                TextPosition(offset: controller.text.length));
          }
        },
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
          hintText: "Add your text",
        ),
      ),
    );
  }
}
