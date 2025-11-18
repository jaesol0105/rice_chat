import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_view_model.g.dart';

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  int build() {
    return 0; // 초기 화면 인덱스
  }

  void onIndexChanged(int newIndex) {
    state = newIndex;
  }
}
