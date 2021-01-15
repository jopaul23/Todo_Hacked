import 'package:Todo_App/AccountPage/Functions/chart.dart';
import 'package:Todo_App/Helper%20Widgets/Toast/toast.dart';
import 'package:Todo_App/Helper%20Widgets/button.dart';
import 'package:Todo_App/Helper%20Widgets/textfield.dart';
import 'package:Todo_App/Router/page_router.dart';
import 'package:flutter/material.dart';
import 'package:Todo_App/styles/styles.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class WelcomeScreen extends HookWidget {
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final name = useState("");
    print("called");
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: size.height,
            decoration: BoxDecoration(
              gradient: Styles.t1Gradient,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.09,
                ),
                Image(
                  image: Image.asset("assets/Images/L1.png").image,
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
                    style: TextStyle(fontSize: 25, color: Styles.white1),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.25,
                ),
                InputTextField(
                  labelText: "Nickname",
                  onChanged: (val) {
                    print(val);
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
                  textcolor: Styles.t1Orange,
                  buttoncolor: Styles.white1,
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
