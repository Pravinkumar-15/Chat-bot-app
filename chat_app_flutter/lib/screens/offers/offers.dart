import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Offers extends StatelessWidget {
  const Offers({super.key});

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
            Text("Coming soon...", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
