import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rice_chat/data/model/post_entity.dart';

part 'home_tab_state.freezed.dart';

@freezed
abstract class HomeTabState with _$HomeTabState {
  const factory HomeTabState({@Default('') String address, @Default([]) List<PostEntity> posts}) =
      _HomeTabState;
}
