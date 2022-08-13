part of 'edit_story_bloc.dart';

enum EditStoryStatus { initial, loading, success, failure }

extension EditStoryStatusX on EditStoryStatus {
  bool get isLoadingOrSuccess => [
        EditStoryStatus.loading,
        EditStoryStatus.success,
      ].contains(this);
}

class EditStoryState extends Equatable {
  const EditStoryState({
    this.status = EditStoryStatus.initial,
    this.initialStory,
    this.id = '',
    // this.tags = const <String>[],
    this.newTag = '',
  });

  final EditStoryStatus status;
  final Story? initialStory;
  final String id;
  // final List<String> tags;
  final String newTag;

  bool get isNewStory => initialStory == null;

  EditStoryState copyWith({
    EditStoryStatus? status,
    Story? initialStory,
    String? id,
    // List<String>? tags,
    String? newTag,
  }) {
    return EditStoryState(
      status: status ?? this.status,
      initialStory: initialStory ?? this.initialStory,
      id: id ?? this.id,
      // tags: tags ?? this.tags,
      newTag: newTag ?? this.newTag,
    );
  }

  @override
  List<Object?> get props => [status, initialStory, id, newTag];
}
