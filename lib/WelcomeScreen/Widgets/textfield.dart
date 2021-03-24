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
    const TextStyle noCharacterStyle =
        TextStyle(fontWeight: FontWeight.bold, color: Styles.t1Orange);
    const TextStyle textFieldStyle =
        TextStyle(color: Styles.white1, fontSize: 25);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.centerRight,
            child: Visibility(
              visible: noCharacters.value != 0,
              child: Container(
                height: 40,
                width: 45,
                decoration: BoxDecoration(
                    color: Styles.white2,
                    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                    boxShadow: [Styles.shadow()]),
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${noCharacters.value}/$maxLength",
                    style: noCharacterStyle,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
              color: Styles.white2,
              borderRadius: const BorderRadius.all(Radius.circular(35.0)),
              boxShadow: [Styles.shadow()]),
          child: TextField(
            cursorColor: Styles.white1,
            controller: textController,
            onChanged: (String val) {
              onChange(val, textController, noCharacters, maxLength);
            },
            textAlign: TextAlign.center,
            style: textFieldStyle,
            decoration: InputDecoration(
              counterText: "",
              hintText: labelText,
              // hintStyle: Theme.of(context).tex,
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  void onChange(String val, textController, noCharacters, maxLength) {
    if (val.length > maxLength) {
      // to limit the number of characters to the maxLength..
      textController.text = textController.text.substring(0, 8);
      textController.selection = TextSelection.fromPosition(
          TextPosition(offset: textController.text.length));
    } else
      noCharacters.value = val.length;
    onChanged(textController.text);
  }
}
