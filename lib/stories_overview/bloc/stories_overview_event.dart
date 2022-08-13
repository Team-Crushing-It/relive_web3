part of 'stories_overview_bloc.dart';

abstract class StoriesOverviewEvent extends Equatable {
  const StoriesOverviewEvent();

  @override
  List<Object> get props => [];
}

class StoriesOverviewSubscriptionRequested extends StoriesOverviewEvent {
  const StoriesOverviewSubscriptionRequested();
}


class StoriesOverviewAdd extends StoriesOverviewEvent {
  const StoriesOverviewAdd();
}

class StoriesOverviewStoryCompletionToggled extends StoriesOverviewEvent {
  const StoriesOverviewStoryCompletionToggled({
    required this.story,
    required this.isCompleted,
  });

  final Story story;
  final bool isCompleted;

  @override
  List<Object> get props => [story, isCompleted];
}

class StoriesOverviewStoryDeleted extends StoriesOverviewEvent {
  const StoriesOverviewStoryDeleted(this.story);

  final Story story;

  @override
  List<Object> get props => [story];
}

class StoriesOverviewUndoDeletionRequested extends StoriesOverviewEvent {
  const StoriesOverviewUndoDeletionRequested();
}

class StoriesOverviewFilterChanged extends StoriesOverviewEvent {
  const StoriesOverviewFilterChanged(this.filter);

  final StoriesViewFilter filter;

  @override
  List<Object> get props => [filter];
}

class StoriesOverviewToggleAllRequested extends StoriesOverviewEvent {
  const StoriesOverviewToggleAllRequested();
}

class StoriesOverviewClearCompletedRequested extends StoriesOverviewEvent {
  const StoriesOverviewClearCompletedRequested();
}
