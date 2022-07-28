part of 'stories_overview_bloc.dart';

enum StoriesOverviewStatus { initial, loading, success, failure }

class StoriesOverviewState extends Equatable {
  const StoriesOverviewState({
    this.status = StoriesOverviewStatus.initial,
    this.stories = const [],
    this.filter = StoriesViewFilter.all,
    this.lastDeletedStory,
  });

  final StoriesOverviewStatus status;
  final List<Story> stories;
  final StoriesViewFilter filter;
  final Story? lastDeletedStory;

  Iterable<Story> get filteredStories => filter.applyAll(stories);

  StoriesOverviewState copyWith({
    StoriesOverviewStatus Function()? status,
    List<Story> Function()? stories,
    StoriesViewFilter Function()? filter,
    Story? Function()? lastDeletedStory,
  }) {
    return StoriesOverviewState(
      status: status != null ? status() : this.status,
      stories: stories != null ? stories() : this.stories,
      filter: filter != null ? filter() : this.filter,
      lastDeletedStory:
          lastDeletedStory != null ? lastDeletedStory() : this.lastDeletedStory,
    );
  }

  @override
  List<Object?> get props => [
        status,
        stories,
        filter,
        lastDeletedStory,
      ];
}
