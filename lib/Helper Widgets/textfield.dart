import 'package:Todo_App/Helper%20Widgets/shadow.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InputTextField extends HookWidget {
  final String labelText;
  final Function(String) onChanged;
  const InputTextField({this.onChanged, this.labelText = ""});

  Widget build(BuildContext context) {
    const int maxLength = 8;
    final noCharacters = useState(0);
    final textController = useTextEditingController();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Visibility(
              visible: noCharacters.value != 0,
              child: BoxShadowContainer(
                height: 40,
                width: 45,
                radius: BorderRadius.all(Radius.circular(10)),
                color: Styles.white2,
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${noCharacters.value}/$maxLength",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Styles.t1Orange),
                  ),
                ),
              ),
            ),
          ),
        ),
        BoxShadowContainer(
          child: TextField(
            controller: textController,
            onChanged: (String val) {
              if (val.length > maxLength) {
                textController.text = textController.text.substring(0, 8);
                textController.selection = TextSelection.fromPosition(
                    TextPosition(offset: textController.text.length));
              } else
                noCharacters.value = val.length;
            },
            textAlign: TextAlign.center,
            cursorColor: Styles.white3.withOpacity(0.3),
            style: TextStyle(color: Styles.white1, fontSize: 25),
            decoration: InputDecoration(
              counterText: "",
              hintText: labelText,
              hintStyle: TextStyle(
                color: Styles.white1.withOpacity(.59),
                fontSize: 25,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
