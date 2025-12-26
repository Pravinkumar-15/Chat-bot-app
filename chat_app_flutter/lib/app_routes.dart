import 'package:flutter/material.dart';

import 'package:chat_app_flutter/screens/all_chats/chats.dart';
import 'package:chat_app_flutter/screens/chat_history/chat_history.dart';
import 'package:chat_app_flutter/screens/settings/settings.dart';
import 'package:chat_app_flutter/screens/offers/offers.dart';

class AppRoutes {
  // Route names
  static const String allChats = '/allChats';
  static const String chatHistory = '/chatHistory';
  static const String settings = '/settings';
  static const String offers = '/offers';

  // Route map
  static Map<String, WidgetBuilder> get routes => {
    allChats: (context) => Chats(),
    chatHistory: (context) => const ChatHistory(),
    settings: (context) => const Settings(),
    offers: (context) => const Offers(),
  };
}
