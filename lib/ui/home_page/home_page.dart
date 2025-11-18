import 'package:flutter/material.dart';
import 'package:rice_chat/ui/home_page/widgets/home_bottom_navigation_bar.dart';
import 'package:rice_chat/ui/home_page/widgets/home_floating_action_button.dart';
import 'package:rice_chat/ui/home_page/widgets/home_indexed_stack.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeIndexedStack(),
      bottomNavigationBar: HomeBottomNavigationBar(),
      floatingActionButton: HomeFloatingActionButton(),
    );
  }
}
