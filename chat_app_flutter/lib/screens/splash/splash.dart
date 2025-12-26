import 'package:chat_app_flutter/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.allChats);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 220,
              width: 220,
              child: Lottie.asset('assets/chat_bot.json', fit: BoxFit.contain),
            ),

            Text("Welcome to HuskChat", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
