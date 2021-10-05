import 'package:ananke_mobile/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xffF58D14),
        colorScheme: const ColorScheme.light(
            background: Color(0xffEBEBEB), surface: Color(0xffE0E0E0)),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xffF58D14),
        colorScheme: const ColorScheme.dark(
            background: Color(0xff202020), surface: Color(0xff3A3A3A)),
      ),
    );
  }
}
