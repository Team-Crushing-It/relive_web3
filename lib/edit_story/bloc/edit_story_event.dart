part of 'edit_story_bloc.dart';

abstract class EditStoryEvent extends Equatable {
  const EditStoryEvent();

  @override
  List<Object> get props => [];
}


class EditStoryTagAdded extends EditStoryEvent {
  const EditStoryTagAdded(this.tag);

  final String tag;

  @override
  List<Object> get props => [tag];
}

class EditStorySubmitted extends EditStoryEvent {
  const EditStorySubmitted();
}
