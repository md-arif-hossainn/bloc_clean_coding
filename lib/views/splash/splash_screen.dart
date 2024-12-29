import 'package:bloc_clean_coding/config/components/internet_exception_widget.dart';
import 'package:bloc_clean_coding/config/components/loading_widget.dart';
import 'package:bloc_clean_coding/config/components/round_button.dart';
import 'package:bloc_clean_coding/config/routes/routes_name.dart';
import 'package:bloc_clean_coding/services/splash/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  SplashServices splashServices = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashServices.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('splash screen',style: TextStyle(
              color: Colors.blueAccent,
              fontSize: 26,
            ),),

          ],
        )

      ),
    );
  }
}
