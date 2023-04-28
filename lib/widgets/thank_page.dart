import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fkrety/models/language_const.dart';
import 'package:flutter/material.dart';

import '../screens/main_screen.dart';

class ThankfulPage extends StatelessWidget {
  static const routeName = '/thankful';
  const ThankfulPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        height: 200,
        width: 200,
        child: Column(
          children: [
            Container(
              height: 80,
              width: 100,
              child: Image.asset('assets/images/thank.png'),
            ),
            Center(
              child: Text(
                translation(context)!.thankful,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            )
          ],
        ),
      ),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 200,
      duration: 3500,
      backgroundColor: Colors.black,
      nextScreen: MainScreen(),
    );
  }
}
