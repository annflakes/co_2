import 'package:co_2/signup.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoHome();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFD1D1D1) // Equivalent to RGB(209, 209, 209)

 // Light Grayq
        ),
        child: Center(
          child: Image.asset(
            'assets/Logo.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain, // Ensures the full image is visible without cropping
          ),
        ),
      ),
    );
  }

  Future<void> gotoHome() async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (ctx) => SignupScreen()),
    );
  }
}