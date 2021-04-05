import 'package:flutter/material.dart';
import 'package:todo_app/Helper%20Widgets/button.dart';
import 'package:todo_app/TodoAddPage/Widgets/addpage_layout.dart';

class InstantTodo extends StatelessWidget {
  final double minHeight;
  final Function() updateHeight;
  const InstantTodo({Key key, this.minHeight, this.updateHeight})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: minHeight),
      child: Material(
        color: theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(children: [
            AddPageLayout.textField(context, "title"),

            // opacity: ((height / maxHeight) * 100) / 100,

            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                  onPressed: () {
                    updateHeight();
                  },
                  child: Text(
                    "Advanced option",
                    style: theme.textTheme.bodyText1.copyWith(fontSize: 16),
                  )),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Button(text: "Add Todo", onPressed: () {})),
          ]),
        ),
      ),
    );
  }
}
