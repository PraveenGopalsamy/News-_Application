import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AnimatedSplashScreen(
            duration: 2000,
            splash: Column(mainAxisSize: MainAxisSize.min, children: const [
              Icon(Icons.newspaper, size: 45),
              Text('News+',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23))
            ]),
            nextScreen: const LoginScreen(title: 'News+'),
            //nextScreen: const HomeScreen(userName: 'News+'),
            splashTransition: SplashTransition.rotationTransition,
            backgroundColor: Colors.blue));
  }
}
