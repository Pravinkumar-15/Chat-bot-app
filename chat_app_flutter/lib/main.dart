import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_app_flutter/screens/splash/splash.dart';
import 'package:chat_app_flutter/app_routes.dart';
import 'package:chat_app_flutter/services/chat_api_services.dart';
import 'package:chat_app_flutter/services/chat_provider.dart';
import 'package:chat_app_flutter/services/chat_repository.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ChatProvider(ChatRepository(ChatApiServices())),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: GoogleFonts.lexendTextTheme(),
      ),
      // Initial route
      home: const Splash(),
      // Named routes for navigation (centralized in AppRoutes)
      routes: AppRoutes.routes,
    );
  }
}
