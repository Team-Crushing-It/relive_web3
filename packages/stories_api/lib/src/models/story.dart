// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'story.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Story extends Equatable {
  final String? id;
  final List<String>? tags;
  final File? file;

  const Story({
    this.id,
    this.tags,
    this.file,
  });

  Story copyWith({
    String? id,
    List<String>? tags,
    File? file,
  }) {
    return Story(
      id: id ?? this.id,
      tags: tags ?? this.tags,
      file: file ?? this.file,
    );
  }

  @override
  String toString() {
    return 'Story{id: $id, tags: $tags,}';
  }

  /// Empty Story which represents an empty story.
  static var empty = Story(
    id: '',
    tags: [],
    file: File('empty'),
  );

  /// Convenience getter to determine whether the story is empty.
  bool get isEmpty => this == Story.empty;

  /// Convenience getter to determine whether the story is not empty.
  bool get isNotEmpty => this != Story.empty;

  @override
  List<Object?> get props => [
        id,
        tags,
      ];

  factory Story.fromJson(Map<String, dynamic> json) => _$StoryFromJson(json);

  Map<String, dynamic> toJson() => _$StoryToJson(this);
}
