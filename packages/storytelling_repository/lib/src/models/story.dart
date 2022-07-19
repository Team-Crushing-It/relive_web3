// ignore_for_file: public_member_api_docs

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'vid.g.dart';

@immutable
@JsonSerializable(explicitToJson: true)
class Vid extends Equatable {
  final String? id;
  final List<String>? tags;
  final File? file;

  const Vid({
    this.id,
    this.tags,
    this.file,
  });

  Vid copyWith({
    String? id,
    List<String>? tags,
    File? file,
  }) {
    return Vid(
      id: id ?? this.id,
      tags: tags ?? this.tags,
      file: file ?? this.file,
    );
  }

  @override
  String toString() {
    return 'Vid{id: $id, tags: $tags,}';
  }

  /// Empty Vid which represents an empty video.
  static var empty = Vid(
    id: '',
    tags: [],
    file: File('empty'),
  );

  /// Convenience getter to determine whether the video is empty.
  bool get isEmpty => this == Vid.empty;

  /// Convenience getter to determine whether the video is not empty.
  bool get isNotEmpty => this != Vid.empty;

  @override
  List<Object?> get props => [
        id,
        tags,
      ];

  factory Vid.fromJson(Map<String, dynamic> json) => _$VidFromJson(json);

  Map<String, dynamic> toJson() => _$VidToJson(this);
}
