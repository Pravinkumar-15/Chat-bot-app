import 'package:chat_app_flutter/constants/constant.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.side, required this.text});

  final MessageSide side;
  final String text;

  @override
  Widget build(BuildContext context) {
    final isRight = side == MessageSide.right;
    final bubbleColor = isRight
        ? const Color(0xFF2563EB)
        : const Color(0xFFF3F4F6);
    final textColor = isRight ? Colors.white : Colors.black;

    return Container(
      constraints: const BoxConstraints(maxWidth: 250),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: isRight ? Radius.zero : const Radius.circular(16),
          bottomRight: isRight ? const Radius.circular(16) : Radius.zero,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
