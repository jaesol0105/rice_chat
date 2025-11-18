import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rice_chat/ui/home_page/_tab/home_tab/home_tab_view_model.dart';

class HomeTabAppBar extends ConsumerWidget {
  const HomeTabAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeTabViewModelProvider);

    return AppBar(
      title: state.when(
        data: (state) => Text(state.address),
        loading: () => const Text(""),
        error: (e, st) => Text("error: $e"),
      ),
    );
  }
}
