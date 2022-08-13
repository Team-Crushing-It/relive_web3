// ignore_for_filePath: public_member_api_docs

// ignore_for_file: public_member_api_docs, type_annotate_public_apis

// import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'story.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Story extends Equatable {

  const Story({
    this.id,
    this.tags = const [],
    this.filePath = '',
  });
  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);
  final String? id;
  final List<String> tags;
  final String? filePath;

  Story copyWith({
    String? id,
    List<String>? tags,
    String? filePath,
  }) {
    return Story(
      id: id ?? this.id,
      tags: tags ?? this.tags,
      filePath: filePath ?? this.filePath,
    );
  }

  @override
  String toString() {
    return 'Story{id: $id, tags: $tags,}';
  }

  /// Empty Story which represents an empty story.
  static var empty = const Story(
    id: '',
  );

  /// Convenience getter to determine whether the story is empty.
  bool get isEmpty => this == Story.empty;

  /// Convenience getter to determine whether the story is not empty.
  bool get isNotEmpty => this != Story.empty;

  @override
  List<Object?> get props => [id, tags, filePath];

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
