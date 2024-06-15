import 'package:flutter/material.dart';
import 'package:nephrology_app/pages/layout.dart';
import 'package:nephrology_app/shared/color.dart';


void main() {
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
          fontFamily: 'Poppins',
          primaryColor: primaryColor,
          scaffoldBackgroundColor: bgColor ),
      initialRoute: "/LayOutScreen",
      routes: {
        "/LayOutScreen": (context) => const LayOut(),
      },
    );
  }
}

