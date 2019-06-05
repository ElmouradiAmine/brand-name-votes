import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Brand Name Votes',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
