import 'package:firebase_core/firebase_core.dart';
import 'package:fkrety/widgets/thank_page.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import './models/language_const.dart';

import './screens/first_data_screen.dart';
import './screens/second_data_screen.dart';
import './screens/third_data_screen.dart';
import './screens/forth__dataa_screen.dart';
import './screens/ideas_screen.dart';
import './screens/main_screen.dart';
import './widgets/options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>()!;
    state.setLocale(newLocale);
  }
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    getLocale().then((locale) => setLocale(locale));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: _locale,
      home: AnimatedSplashScreen(
        splash: Container(
          height: 200,
          width: 200,
          child: Column(
            children: [
              Container(
                height: 125,
                width: 200,
                child: Image.asset('assets/images/idea.png'),
              ),
              Text(
                'فكرتك',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
        ),
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 200,
        duration: 3000,
        backgroundColor: Colors.black,
        nextScreen: MainScreen(),
      ),
      routes: {
        MainScreen.routeName: (context) => MainScreen(),
        IdeaScreen.routName: (context) => IdeaScreen(),
        ThankfulPage.routeName: (context) => ThankfulPage(),
        FirstDataScreen.routeName: (context) => FirstDataScreen(),
        SecondDataScreen.routeName: (context) => SecondDataScreen(),
        ThirdDataScreen.routeName: (context) => ThirdDataScreen(),
        ForthDataaScreen.routeName: (context) => ForthDataaScreen(),
        SettingsPage.routName: (context) => SettingsPage(),
      },
    );
  }
}
