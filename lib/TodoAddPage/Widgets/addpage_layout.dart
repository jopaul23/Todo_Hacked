import 'package:flutter/material.dart';
import 'package:todo_app/TodoAddPage/Widgets/advanced_todo.dart';
import '../../Themes/colors.dart' as appColors;
import 'instant_todo.dart';

class AddPageLayout extends StatefulWidget {
  final OverlayEntry entry;
  final Size size;
  const AddPageLayout({Key key, @required this.entry, @required this.size})
      : super(key: key);
  @override
  _AddPageLayoutState createState() => _AddPageLayoutState();

  static Widget textField(BuildContext context, String hintText) {
    final theme = Theme.of(context);
    return Container(
      height: 50.0,
      // margin: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextField(
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
            hintText: hintText,
            enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: theme.primaryColor, width: 2.0)),
            border: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                borderSide: BorderSide(color: theme.primaryColor, width: 2.0))),
      ),
    );
  }
}

class _AddPageLayoutState extends State<AddPageLayout> {
  double containerHeight, maxHeight, minHeight;
  Size size;

  @override
  void initState() {
    super.initState();
    size = widget.size;
    maxHeight = size.height - size.height * 0.21;
    minHeight = size.height * 0.4;
    containerHeight = minHeight;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        curve: Curves.linear,
        duration: const Duration(milliseconds: 100),
        height: containerHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          color: theme.accentColor,
          borderRadius: const BorderRadius.all(Radius.circular(30.0)),
          boxShadow: [appColors.shadow.scale(10)],
        ),
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              ConstrainedBox(
                constraints:
                    BoxConstraints(maxHeight: 10.0, maxWidth: double.infinity),
                child: Stack(
                  children: [
                    GestureDetector(
                      onPanEnd: (_) {
                        if (containerHeight < minHeight - 20)
                          widget.entry.remove();
                        else if (containerHeight > maxHeight)
                          this.setState(() {
                            containerHeight = maxHeight;
                          });
                      },
                      onPanUpdate: (details) {
                        onPanUpdate(details, size.height);
                      },
                    ),
                    Divider(
                      color: theme.primaryColor,
                      thickness: 4.0,
                      endIndent: size.width * 0.4,
                      indent: size.width * 0.4,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              Text("Add Todo", style: theme.textTheme.headline3),
              const SizedBox(height: 20.0),
              containerHeight <= minHeight + 100
                  ? InstantTodo(
                      minHeight: minHeight,
                      updateHeight: () {
                        this.setState(() {
                          containerHeight = maxHeight;
                        });
                      },
                    )
                  : AdvancedTodo(
                      maxHeight: maxHeight,
                      minHeight: minHeight,
                      height: containerHeight,
                    )
            ],
          ),
        ),
      ),
    );
  }

  void onPanUpdate(DragUpdateDetails details, double screenHeight) {
    final dy = details.globalPosition.dy;
    if (dy <= screenHeight && dy > 0)
      setState(() {
        containerHeight = screenHeight - dy;
      });
  }
}
