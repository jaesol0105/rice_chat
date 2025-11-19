import 'package:flutter/material.dart';
import 'package:rice_chat/ui/home_page/_tab/profile_tab/widgets/profile_list.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProfileList(),
    );
  }
}
