import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/home_tab_view_model.dart';
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
          onPressed: () async {
            // 본인이 글을 썼을 경우 결과 받아서 reload 해준다.
            final result = await Navigator.push<bool>(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return PostWritePage();
                },
              ),
            );
            if (result == true) {
              ref.invalidate(homeTabViewModelProvider);
            }
          },
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
          child: Icon(Icons.add),
        );
      },
    );
  }
}
