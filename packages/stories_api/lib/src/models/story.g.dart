// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'story.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Story _$StoryFromJson(Map<String, dynamic> json) => Story(
      id: json['id'] as String?,
      tags: (json['tags'] as List<dynamic>?)
              ?.map((dynamic e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$StoryToJson(Story instance) => <String, dynamic>{
      'id': instance.id,
      'tags': instance.tags,
    };
