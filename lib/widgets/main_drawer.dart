import 'package:flutter/material.dart';

import '../screens/main_screen.dart';
import '../models/language_const.dart';
import './options.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tabHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RootoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tabHandler as void Function()?,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Colors.black87,
            child: Text(
              translation(context)!.settings,
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 30,
                color: Colors.amber,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          buildListTile(
            translation(context)!.home,
            Icons.home,
            () {
              Navigator.of(context).pushNamed(MainScreen.routeName);
            },
          ),
          buildListTile(
            translation(context)!.settings,
            Icons.settings,
            () {
              Navigator.of(context).pushNamed(SettingsPage.routName);
            },
          ),
        ],
      ),
    );
  }
}
