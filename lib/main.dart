import 'package:flutter/material.dart';
import 'package:to_do_app/pages/Home_Page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.yellow,
        appBarTheme: AppBarTheme(backgroundColor: Colors.yellow),
      ),
      home: HomePage(),
    );
  }
}
