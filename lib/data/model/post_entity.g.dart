// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostEntity _$PostEntityFromJson(Map<String, dynamic> json) => _PostEntity(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  writer: json['writer'] as String,
  createdAt: _convertToDateTime(json['created_at']),
  images: (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
  provider: json['provider'] as String?,
);

Map<String, dynamic> _$PostEntityToJson(_PostEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'writer': instance.writer,
      'created_at': _convertToTimestamp(instance.createdAt),
      'images': instance.images,
      'provider': instance.provider,
    };
