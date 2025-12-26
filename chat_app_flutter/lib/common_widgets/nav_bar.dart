import 'package:chat_app_flutter/constants/constant.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_flutter/global.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  void _onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        // Home -> All Chats
        Global.pageStateStream.add({"index": 0, "state": PageState.home});

        break;
      case 1:
        // Offers
        Global.pageStateStream.add({"index": 1, "state": PageState.offers});
        break;
      case 2:
        Global.pageStateStream.add({"index": 2, "state": PageState.settings});
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Global.pageStateStream.stream,
      builder: (context, asyncSnapshot) {
        return BottomNavigationBar(
          currentIndex: asyncSnapshot.data?["index"] ?? 0,
          onTap: (index) => _onItemTapped(context, index),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.local_offer_outlined),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
