part of 'edit_story_bloc.dart';

abstract class EditStoryEvent extends Equatable {
  const EditStoryEvent();

  @override
  List<Object> get props => [];
}


class EditStoryTagsChanged extends EditStoryEvent {
  const EditStoryTagsChanged(this.tags);

  final List<String> tags;

  @override
  List<Object> get props => [tags];
}

class EditStorySubmitted extends EditStoryEvent {
  const EditStorySubmitted();
}
