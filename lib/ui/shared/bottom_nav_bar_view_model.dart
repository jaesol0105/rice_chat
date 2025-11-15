import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_bar_view_model.g.dart';

@riverpod
class BottomNavBarViewModel extends _$BottomNavBarViewModel {
  @override
  int build() {
    // 초기 인덱스
    return 0;
  }

  void onIndexChanged(int newIndex) {
    state = newIndex;
  }
}
