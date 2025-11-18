import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_entity.freezed.dart';
part 'chat_entity.g.dart';

@freezed
abstract class ChatEntity with _$ChatEntity {
  const factory ChatEntity({
    required String id,
    required String sender, // 메세지 쓴 사람
    @JsonKey(name: 'sender_id') required String senderId, // 메세지 쓴 사람 고유 ID
    required String message, // 메세지 내용
    @JsonKey(name: 'created_at', fromJson: _convertToDateTime, toJson: _convertToTimestamp)
    required DateTime? createdAt, // 메세지 작성 날짜 및 시간
    @JsonKey(name: 'image_url') required String imageUrl, // 메세지 쓴 사람 이미지
  }) = _ChatEntity;

  factory ChatEntity.fromJson(Map<String, dynamic> json) => _$ChatEntityFromJson(json);
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
