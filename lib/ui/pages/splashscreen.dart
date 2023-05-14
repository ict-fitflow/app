import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {

  // next page to load
  final Widget nextPage;

  const SplashScreen({Key? key, required this.nextPage }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 2000,
        splash: Image.asset("assets/logo.png"),
        nextScreen: nextPage,
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Colors.white
      )
    );
  }
}