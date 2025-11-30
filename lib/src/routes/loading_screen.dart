import 'dart:async';
import 'package:flutter/material.dart';
import '../pages/Credentials/loginpage.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Timer(const Duration(seconds: 2),
    (){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Image.asset('assets/images/Inter.jpg',
        fit: BoxFit.cover,
        ),
        
      ),
    );
  }
}