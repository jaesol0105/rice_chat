import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/home_tab.dart';
import 'package:rice_chat/ui/home_page/home_view_model.dart';

class HomeIndexedStack extends StatelessWidget {
  const HomeIndexedStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModelProvider);
        return IndexedStack(index: currentIndex, children: [HomeTab()]);
      },
    );
  }
}
