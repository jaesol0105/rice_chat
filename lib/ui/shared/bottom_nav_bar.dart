import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rice_chat/ui/shared/bottom_nav_bar_view_model.dart';

class BottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(bottomNavBarViewModelProvider);
        final viewModel = ref.read(bottomNavBarViewModelProvider.notifier);
        return BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: viewModel.onIndexChanged,
          iconSize: 28,
          selectedLabelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 12),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.house_outlined),
              activeIcon: Icon(Icons.home),
              label: '홈',
              tooltip: '홈',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.chat_bubble_2),
              activeIcon: Icon(CupertinoIcons.chat_bubble_2_fill),
              label: '채팅',
              tooltip: '채팅',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person),
              activeIcon: Icon(CupertinoIcons.person_fill),
              label: '프로필',
              tooltip: '프로필',
            ),
          ],
        );
      },
    );
  }
}
