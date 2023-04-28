import 'package:fkrety/models/language_const.dart';
import 'package:flutter/material.dart';

Widget myAppBar(BuildContext context) {
  return AppBar(
    title: Text(translation(context)!.homePage),
    elevation: 10,
    titleSpacing: 0,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/light.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
