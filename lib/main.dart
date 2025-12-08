import 'package:flutter/material.dart';
import 'package:hungry/features/auth/view/login_view.dart';
import 'package:hungry/root.dart';
import 'package:hungry/splash_screen.dart';

import 'features/auth/view/signup_view.dart';

void main (){
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white
      ),
      debugShowCheckedModeBanner: false,
      title: 'Hungry App',
      home:  Root(),
    );
  }
}


