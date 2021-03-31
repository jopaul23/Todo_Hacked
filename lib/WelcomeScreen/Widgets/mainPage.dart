import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../AccountPage/Functions/chart.dart';
import '../../Overlays/Toast/toast_overlay.dart';
import '../../styles/images.dart';
import 'textfield.dart';
import '../../Helper%20Widgets/button.dart';
import '../../Router/page_router.dart';

class WelcomeScreen extends HookWidget {
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final name = useState("");
    final theme = Theme.of(context);
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
            )),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.09,
                ),
                Image(
                  image: ImportedImages.logoCircle,
                  height: 64,
                  width: 64,
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Container(
                  width: 350,
                  child: Text(
                    "Welcome, Please enter your beautiful name",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline2,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.25,
                ),
                InputTextField(
                  labelText: "Nickname",
                  onChanged: (val) {
                    name.value = val;
                  },
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Button(
                  text: "CONTINUE",
                  onPressed: () {
                    onToogleContinueBtn(context, name.value);
                  },
                  textcolor: theme.primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onToogleContinueBtn(context, String name) {
    if (name.isNotEmpty) {
      TodoChart.createBox(name);

      PageRouter.sailor.navigate(PageRouter.homePage);
    } else {
      Toast("Nick Name should not be empty")..showToast(context);
    }
  }
}
