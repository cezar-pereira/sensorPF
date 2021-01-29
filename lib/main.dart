import 'package:flutter/material.dart';

import 'app/modules/home/home_page.dart';

void main() {
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
            headline1: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w400, fontSize: 40),
            headline2: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w100, fontSize: 40),
            headline3: TextStyle(
                color: Color(0xFF292929).withOpacity(0.9),
                fontWeight: FontWeight.w300,
                fontSize: 45),
            headline4: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w100, fontSize: 45),
            headline5: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w100, fontSize: 20),
            headline6: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 25),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          appBarTheme: AppBarTheme(
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.white),
          ),
          accentColor: Colors.amber,
          primarySwatch: Colors.amber,
          canvasColor: Color(0xFF292929)),
      home: HomePage(),
    );
  }
}
