import 'package:flutter/material.dart';

import '../models/language_const.dart';

Widget headOfPage(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height / 10,
    alignment: Alignment.center,
    child: Text(
      translation(context)!.personalInformation,
      style: TextStyle(
        fontSize: 28,
        fontFamily: 'RobotoCondensed',
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
