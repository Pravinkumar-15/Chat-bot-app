import 'package:flutter/material.dart';

import 'package:chat_app_flutter/common_widgets/circle_avatar.dart';
import 'package:chat_app_flutter/common_widgets/chat_bubble.dart';
import 'package:chat_app_flutter/constants/constant.dart';
import 'package:chat_app_flutter/models/chat_message.dart';

class InChat extends StatefulWidget {
  const InChat({super.key, required this.userName, required this.lastMessage});

  final String userName;
  final String lastMessage;

  @override
  State<InChat> createState() => _InChatState();
}

class _InChatState extends State<InChat> {
  late final ValueNotifier<List<ChatMessage>> _messages =
      ValueNotifier<List<ChatMessage>>(_initialMessages());

  List<ChatMessage> _initialMessages() {
    return <ChatMessage>[
      ChatMessage(
        side: MessageSide.left,
        text: widget.lastMessage,
        time: '10:30 AM',
      ),
      const ChatMessage(
        side: MessageSide.right,
        text: "I'm doing great, thanks!\nHow about you?",
        time: '10:31 AM',
      ),
      const ChatMessage(
        side: MessageSide.left,
        text: 'Pretty good! Just wanted\nto check in about the\nproject.',
        time: '10:32 AM',
      ),
      const ChatMessage(
        side: MessageSide.right,
        text: "Oh yes, I've been making\ngood progress on it.",
        time: '10:33 AM',
      ),
      const ChatMessage(
        side: MessageSide.right,
        text: 'Should be ready by\ntomorrow.',
        time: '10:33 AM',
      ),
      const ChatMessage(
        side: MessageSide.left,
        text: "That's awesome! Let me\nknow if you need any\nhelp.",
        time: '10:34 AM',
      ),
      const ChatMessage(
        side: MessageSide.right,
        text: 'Will do, thanks!',
        time: '10:35 AM',
      ),
    ];
  }

  @override
  void dispose() {
    _messages.dispose();
    super.dispose();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
        onPressed: () => Navigator.of(context).pop(),
      ),
      titleSpacing: 0,
      title: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              color: Color(0xFF6366F1),
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              Constants.initialForName(widget.userName),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Online',
                  style: TextStyle(
                    color: Color(0xFF9CA3AF),
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageRow(ChatMessage msg) {
    final isRight = msg.side == MessageSide.right;
    final avatarLetter = isRight
        ? 'Y'
        : Constants.initialForName(widget.userName);
    final avatarColor = isRight
        ? const Color(0xFFE11D48)
        : const Color(0xFF6366F1);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: isRight
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isRight
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isRight)
                ChatCircleAvatar(letter: avatarLetter, color: avatarColor),
              if (!isRight) const SizedBox(width: 10),
              ChatBubble(side: msg.side, text: msg.text),
              if (isRight) const SizedBox(width: 10),
              if (isRight)
                ChatCircleAvatar(letter: avatarLetter, color: avatarColor),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: EdgeInsets.only(
              left: isRight ? 0 : 44,
              right: isRight ? 44 : 0,
            ),
            child: Text(
              msg.time,
              style: const TextStyle(
                color: Color(0xFF9CA3AF),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
          Expanded(
            child: ValueListenableBuilder<List<ChatMessage>>(
              valueListenable: _messages,
              builder: (context, messages, _) {
                return ListView.builder(
                  padding: const EdgeInsets.only(top: 12, bottom: 12),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessageRow(messages[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
