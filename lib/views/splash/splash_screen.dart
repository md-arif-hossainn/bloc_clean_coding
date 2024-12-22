import 'package:bloc_clean_coding/config/routes/routes_name.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: (){
            Navigator.pushNamed(context, RoutesName.homeScreen);
          },
          child: const Text('Home')
      ),
    );
  }
}
