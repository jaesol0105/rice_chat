import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_entity.freezed.dart';
part 'post_entity.g.dart';

@freezed
abstract class PostEntity with _$PostEntity {
  const factory PostEntity({
    required String id,
    required String title,
    required String content,
    required String writer,
    @JsonKey(name: 'created_at', fromJson: _convertToDateTime, toJson: _convertToTimestamp)
    required DateTime? createdAt,
    //required String profileImgUrl,
    //required String address,
  }) = _PostEntity;

  factory PostEntity.fromJson(Map<String, dynamic> json) => _$PostEntityFromJson(json);
}

/// Timestamp to DateTime
DateTime? _convertToDateTime(dynamic time) {
  if (time == null) return null;
  return time.toDate();
}

/// DateTime to Timestamp
Object? _convertToTimestamp(DateTime? date) {
  if (date == null) return null;
  return Timestamp.fromDate(date);
}
