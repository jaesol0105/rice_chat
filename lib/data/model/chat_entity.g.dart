// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ChatEntity _$ChatEntityFromJson(Map<String, dynamic> json) => _ChatEntity(
  id: json['id'] as String,
  sender: json['sender'] as String,
  senderId: json['sender_id'] as String,
  message: json['message'] as String,
  createdAt: _convertToDateTime(json['created_at']),
  imageUrl: json['image_url'] as String,
);

Map<String, dynamic> _$ChatEntityToJson(_ChatEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': instance.sender,
      'sender_id': instance.senderId,
      'message': instance.message,
      'created_at': _convertToTimestamp(instance.createdAt),
      'image_url': instance.imageUrl,
    };
