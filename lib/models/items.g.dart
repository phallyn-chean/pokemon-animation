// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GithubItemModel _$GithubItemModelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    disallowNullValues: const ['name', 'imageUrl', 'effect'],
  );
  return GithubItemModel(
    json['name'] as String,
    json['category'] as String? ?? '',
    json['imageUrl'] as String,
    json['effect'] as String,
  );
}

Map<String, dynamic> _$GithubItemModelToJson(GithubItemModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'imageUrl': instance.imageUrl,
      'effect': instance.effect,
    };
