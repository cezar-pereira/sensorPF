import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sensor_pf/app/modules/login/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sensor De Temperatura',
      theme: ThemeData(
        textTheme: TextTheme(
          button: TextStyle(
              color: Color(0xFFE1E1E9),
              fontWeight: FontWeight.normal,
              fontSize: 25),
          headline1: TextStyle(
              color: Color(0xFFE1E1E9),
              fontWeight: FontWeight.w400,
              fontSize: 40),
          headline2: TextStyle(
              color: Color(0xFFE1E1E9),
              fontWeight: FontWeight.w100,
              fontSize: 40),
          headline3: TextStyle(
              color: Color(0xFF292929).withOpacity(0.9),
              fontWeight: FontWeight.w300,
              fontSize: 45),
          headline4: TextStyle(
              color: Color(0xFFE1E1E9),
              fontWeight: FontWeight.w100,
              fontSize: 45),
          headline5: TextStyle(
              color: Color(0xFFE1E1E9),
              fontWeight: FontWeight.w100,
              fontSize: 20),
          headline6: TextStyle(
              color: Color(0xFFE1E1E9),
              fontWeight: FontWeight.w200,
              fontSize: 25),
        ),
        iconTheme: IconThemeData(color: Color(0xFFE1E1E9)),
        appBarTheme: AppBarTheme(
          brightness: Brightness.dark,
        ),
        accentColor: Color(0xFFFF734C),
        canvasColor: Color(0xFF1C1C1E),
      ),
      home: LoginPage(),
    );
  }
}
