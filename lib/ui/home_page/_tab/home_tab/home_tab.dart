import 'package:flutter/material.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/widgets/home_tab_app_bar.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/widgets/home_time_based_header.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/widgets/post_list_view.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(child: Column(children: [HomeTimeBasedHeader(), PostListView()]));
  }
}
