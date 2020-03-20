import 'package:flutter/material.dart';
import 'package:healthywheels/screens/signup_screen.dart';
import 'package:healthywheels/screens/login_screen.dart';

class RoutesInfo extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Healthy-Wheels',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.orange,
        ),
        initialRoute: 'login',
        routes: <String, WidgetBuilder>{
          'login': (BuildContext context) => LoginPage(),
          'signup': (BuildContext context) => SignupPage(),
          //'home': (BuildContext context) => HomePage(),
        }
    );
  }
}