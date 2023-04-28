import 'package:flutter/material.dart';

import '../widgets/main_details.dart';
import '../widgets/main_drawer.dart';
import '../models/language.dart';
import '../models/language_const.dart';
import '../main.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/main-screen';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String? value;
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(translation(context)!.homePage),
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 70,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/idea.png'),
              fit: BoxFit.contain,
            ),
          ),
        ),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: DropdownButton<Language>(
                dropdownColor: Colors.white,
                underline: const SizedBox(),
                disabledHint: const SizedBox(),
                focusColor: Colors.transparent,
                icon: Text(
                  translation(context)!.langKey,
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontWeight: FontWeight.bold),
                ),
                onChanged: (Language? language) async {
                  if (language != null) {
                    Locale _locale = await setLocale(language.languageCode);
                    MyApp.setLocale(
                      context,
                      _locale,
                    );
                    value = language.languageCode;
                  }
                },
                items: Language.languageList()
                    .map<DropdownMenuItem<Language>>(
                      (e) => DropdownMenuItem<Language>(
                        value: e,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              e.flag,
                              style: const TextStyle(fontSize: 30),
                            ),
                            Container(width: 60, child: Text(e.name))
                          ],
                        ),
                      ),
                    )
                    .toList(),
              )),
        ],
        foregroundColor: Colors.lightBlueAccent,
      ),
      drawer: MainDrawer(),
      body: MainDetails(),
    );
  }
}
