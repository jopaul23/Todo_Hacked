import 'package:flutter/material.dart';
import '../Themes/colors.dart' as appColors;

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  const Button({@required this.text, this.onPressed});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        // margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        decoration: BoxDecoration(
          boxShadow: [
            appColors.shadow.scale(10),
          ],
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(24),
        ),
        child: TextButton(
          onPressed: onPressed,
          child: Text(text, style: theme.textTheme.bodyText1),
        ),
      ),
    );
  }
}
