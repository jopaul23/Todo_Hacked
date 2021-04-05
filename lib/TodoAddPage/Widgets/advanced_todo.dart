import 'package:flutter/material.dart';
import 'package:todo_app/Helper%20Widgets/Slider/slider.dart';
import 'package:todo_app/Themes/colors.dart';
import 'package:todo_app/TodoAddPage/Widgets/addpage_layout.dart';

class AdvancedTodo extends StatefulWidget {
  final double maxHeight, height, minHeight;

  const AdvancedTodo({Key key, this.maxHeight, this.height, this.minHeight})
      : super(key: key);
  @override
  _AdvancedTodoState createState() => _AdvancedTodoState();
}

class _AdvancedTodoState extends State<AdvancedTodo> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: widget.height),
      child: Material(
        color: theme.backgroundColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AddPageLayout.textField(context, "title"),
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Set Priority",
                      style: theme.textTheme.headline3,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  CustomSlider(
                    backgroundColor: grey1,
                    colors: [
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.red,
                    ],
                    width: MediaQuery.of(context).size.width * 0.8,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
