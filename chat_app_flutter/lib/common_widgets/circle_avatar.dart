import 'package:flutter/material.dart';

class ChatCircleAvatar extends StatelessWidget {
  const ChatCircleAvatar({
    super.key,
    required this.letter,
    required this.color,
    this.size = 34,
  });

  final String letter;
  final Color color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: Text(
        letter,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
