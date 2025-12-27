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
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12,
          ),
          unselectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 12,
          ),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/home-agreement.png",
                height: 20,
                width: 20,
              ),
              activeIcon: Image.asset(
                "assets/images/home-agreement.png",
                height: 20,
                width: 20,
                color: Colors.blue,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/price-tag.png",
                height: 20,
                width: 20,
              ),
              activeIcon: Image.asset(
                "assets/images/price-tag.png",
                height: 20,
                width: 20,
                color: Colors.blue,
              ),
              label: 'Offers',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                "assets/images/settings.png",
                height: 20,
                width: 20,
              ),
              activeIcon: Image.asset(
                "assets/images/settings.png",
                height: 20,
                width: 20,
                color: Colors.blue,
              ),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
