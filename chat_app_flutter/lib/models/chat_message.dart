import 'package:chat_app_flutter/constants/constant.dart';

class ChatMessage {
  const ChatMessage({
    required this.side,
    required this.text,
    required this.time,
  });

  final MessageSide side;
  final String text;
  final String time;
}
