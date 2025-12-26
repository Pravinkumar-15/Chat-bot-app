import 'package:chat_app_flutter/models/comment_model.dart';
import 'package:flutter/material.dart';

class AllChats extends StatelessWidget {
  final CommentModel comment;
  final int index;
  const AllChats({super.key, required this.comment, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blue.shade300],
              ),
            ),
            child: Center(
              child: Text(
                comment.user.fullName.isNotEmpty
                    ? comment.user.fullName.substring(0, 1)
                    : '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          if (index % 2 == 0)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2),
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
      title: Text(
        comment.user.fullName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(comment.body),
    );
  }
}
