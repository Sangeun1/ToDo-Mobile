// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home_page.dart';

void main() async {

  // Initialize Hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('mybox');


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.yellow,
          accentColor: Colors.yellow,
          cardColor: Colors.yellow,
          backgroundColor: Colors.yellow,
          errorColor: Colors.yellow,
          brightness: Brightness.light,
        ),
      ),

      home: HomePage(),
    );
  }
}