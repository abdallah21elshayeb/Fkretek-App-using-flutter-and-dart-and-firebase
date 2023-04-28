import 'package:fkrety/models/language_const.dart';
import 'package:flutter/material.dart';

import '../screens/first_data_screen.dart';
import '../screens/second_data_screen.dart';
import '../screens/third_data_screen.dart';
import '../screens/forth__dataa_screen.dart';
import '../widgets/main_drawer.dart';
import '../widgets/option_item.dart';

class IdeaScreen extends StatelessWidget {
  static const routName = '/idea-details';

  @override
  Widget build(BuildContext context) {
    final PreferredSizeWidget appBar = AppBar(
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      drawer: MainDrawer(),
      body: ListView(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.all(10),
            alignment: Alignment.topCenter,
            child: Text(
              translation(context)!.have,
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 500,
            padding: EdgeInsets.all(20),
            child: GridView.count(
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(20),
              crossAxisCount: 1,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 6.5 / 2,
              children: [
                OptionItem(
                  translation(context)!.idea1,
                  Colors.lightBlueAccent,
                  () {
                    Navigator.of(context).pushNamed(FirstDataScreen.routeName);
                  },
                ),
                OptionItem(
                  translation(context)!.idea2,
                  Colors.lightBlueAccent,
                  () {
                    Navigator.of(context).pushNamed(SecondDataScreen.routeName);
                  },
                ),
                OptionItem(
                  translation(context)!.idea3,
                  Colors.lightBlueAccent,
                  () {
                    Navigator.of(context).pushNamed(ThirdDataScreen.routeName);
                  },
                ),
                OptionItem(
                  translation(context)!.idea4,
                  Colors.lightBlueAccent,
                  () {
                    Navigator.of(context).pushNamed(ForthDataaScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
