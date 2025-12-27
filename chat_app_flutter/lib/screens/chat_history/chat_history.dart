import 'package:chat_app_flutter/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:chat_app_flutter/services/chat_provider.dart';
import 'package:chat_app_flutter/screens/Dm/in_chat.dart';

class ChatHistory extends StatelessWidget {
  const ChatHistory({super.key});

  Widget _buildUnreadBadge(int count) {
    return Container(
      width: 22,
      height: 22,
      decoration: const BoxDecoration(
        color: Color(0xFF1D4ED8),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Text(
        '$count',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1,
        ),
      ),
    );
  }

  Widget _buildTile({
    required String name,
    required String message,
    required String time,
    required int index,
    required VoidCallback onTap,
  }) {
    final unread = Constants.unreadCountForIndex(index);
    final String trimmed = name.trim();
    final String letter = trimmed.isNotEmpty ? trimmed.substring(0, 1) : '?';

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(colors: [Colors.blue, Colors.blue.shade300]),
        ),
        child: Center(
          child: Text(
            letter.toUpperCase(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ),
      ),
      title: Text(
        name,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text(message, maxLines: 1, overflow: TextOverflow.ellipsis),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9CA3AF),
            ),
          ),
          const SizedBox(height: 8),
          if (unread != null) _buildUnreadBadge(unread),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, _) {
        if (chatProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.blue),
          );
        }

        if (chatProvider.errorMessage != null) {
          return Center(child: Text(chatProvider.errorMessage!));
        }

        final comments = chatProvider.comments;
        if (comments.isEmpty) {
          return const Center(child: Text('No chat history'));
        }

        return ListView.separated(
          padding: const EdgeInsets.only(top: 8, bottom: 8),
          itemBuilder: (context, index) {
            final comment = comments[index];
            return _buildTile(
              name: comment.user.fullName,
              message: comment.body,
              time: Constants.timeLabelForIndex(index),
              index: index,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => InChat(
                      userName: comment.user.fullName,
                      lastMessage: comment.body,
                    ),
                  ),
                );
              },
            );
          },
          separatorBuilder: (_, __) =>
              const Divider(height: 1, thickness: 1, color: Color(0xFFF3F4F6)),
          itemCount: comments.length,
        );
      },
    );
  }
}
