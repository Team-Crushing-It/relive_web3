import 'package:stories_repository/stories_repository.dart';

enum StoriesViewFilter { all/*, activeOnly, completedOnly*/ }

extension StoriesViewFilterX on StoriesViewFilter {
  bool apply(Story story) {
    switch (this) {
      case StoriesViewFilter.all:
        return true;
      // case StoriesViewFilter.activeOnly:
      //   return !story.isCompleted;
      // case StoriesViewFilter.completedOnly:
      //   return story.isCompleted;
    }
  }

  Iterable<Story> applyAll(Iterable<Story> stories) {
    return stories.where(apply);
  }
}
