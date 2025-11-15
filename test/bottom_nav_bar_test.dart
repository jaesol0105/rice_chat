import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:rice_chat/ui/shared/bottom_nav_bar.dart';

void main() {
  testWidgets('BottomNavBar', (tester) async {
    // 위젯 렌더
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(home: Scaffold(bottomNavigationBar: BottomNavBar())),
      ),
    );
  });
}
