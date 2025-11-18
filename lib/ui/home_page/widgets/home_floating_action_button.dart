import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_chat/ui/home_page/home_view_model.dart';
import 'package:rice_chat/ui/post_write_page/post_write_page.dart';

class HomeFloatingActionButton extends StatelessWidget {
  const HomeFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final currentIndex = ref.watch(homeViewModelProvider);
        // 홈 화면이 아닐경우 숨기기
        if (currentIndex != 0) {
          return SizedBox();
        }
        return FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PostWritePage();
                },
              ),
            );
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          backgroundColor: Theme.of(context).highlightColor,
          foregroundColor: Colors.white,
          child: Icon(Icons.add),
        );
      },
    );
  }
}
