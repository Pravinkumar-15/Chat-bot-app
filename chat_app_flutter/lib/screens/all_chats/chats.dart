import 'package:chat_app_flutter/common_widgets/nav_bar.dart';
import 'package:chat_app_flutter/common_widgets/switch_widget/switch_widget.dart';
import 'package:chat_app_flutter/constants/constant.dart';
import 'package:chat_app_flutter/global.dart';
import 'package:chat_app_flutter/screens/all_chats/chat_and_history_widgets.dart';
import 'package:chat_app_flutter/screens/chat_history/chat_history.dart';
import 'package:chat_app_flutter/services/chat_provider.dart';
import 'package:chat_app_flutter/screens/offers/offers.dart';
import 'package:chat_app_flutter/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chats extends StatefulWidget {
  const Chats({super.key});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  late final ValueNotifier<bool> _switchController;

  @override
  void initState() {
    super.initState();
    _switchController = ValueNotifier<bool>(false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ChatProvider>().loadComments(limit: 10);
    });
  }

  @override
  void dispose() {
    _switchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavBar(),
      floatingActionButton: StreamBuilder<Map<String, dynamic>>(
        stream: Global.pageStateStream.stream,
        builder: (context, snapshot) {
          final state = snapshot.data?['state'];
          if (state != PageState.home) {
            return const SizedBox.shrink();
          }

          return GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Added user successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.blue.shade300],
                ),
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          );
        },
      ),

      body: SafeArea(
        child: StreamBuilder<Map<String, dynamic>>(
          stream: Global.pageStateStream.stream,
          builder: (context, asyncSnapshot) {
            final chatProvider = context.watch<ChatProvider>();
            if (chatProvider.isLoading) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Center(
                  child: CircularProgressIndicator(color: Colors.blue),
                ),
              );
            }
            switch (asyncSnapshot.data?['state']) {
              case PageState.offers:
                return const Offers();
              case PageState.settings:
                return Settings();
              default:
                return ValueListenableBuilder<bool>(
                  valueListenable: _switchController,
                  builder: (context, isHistorySelected, _) {
                    return CustomScrollView(
                      slivers: [
                        SliverAppBar(
                          pinned: false,
                          floating: true,
                          snap: false,
                          backgroundColor: Theme.of(
                            context,
                          ).scaffoldBackgroundColor,
                          surfaceTintColor: Colors.transparent,
                          elevation: 0,
                          title: SwitchWidget(
                            leftText: 'Users',
                            rightText: 'Chat History',
                            controller: _switchController,
                          ),
                          bottom: const PreferredSize(
                            preferredSize: Size.fromHeight(1),
                            child: Divider(height: 1, thickness: 1),
                          ),
                        ),
                        if (isHistorySelected)
                          const SliverFillRemaining(
                            hasScrollBody: false,
                            child: ChatHistory(),
                          )
                        else
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (chatProvider.errorMessage != null) {
                                  return Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(chatProvider.errorMessage!),
                                  );
                                }

                                if (chatProvider.comments.isEmpty) {
                                  return const Padding(
                                    padding: EdgeInsets.all(16),
                                    child: Text('No comments found'),
                                  );
                                }

                                final comment = chatProvider.comments[index];

                                return AllChats(comment: comment, index: index);
                              },
                              childCount: chatProvider.isLoading
                                  ? 1
                                  : (chatProvider.comments.isEmpty
                                        ? 1
                                        : chatProvider.comments.length),
                            ),
                          ),
                      ],
                    );
                  },
                );
            }
          },
        ),
      ),
    );
  }
}
