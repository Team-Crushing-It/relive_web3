import 'package:stories_api/stories_api.dart';

/// {@template stories_repository}
/// A repository that handles story related requests.
/// {@endtemplate}
class StoriesRepository {
  /// {@macro stories_repository}
  const StoriesRepository({
    required StoriesApi storiesApi,
  }) : _storiesApi = storiesApi;

  final StoriesApi _storiesApi;

  /// Provides a [Stream] of all stories.
  Stream<List<Story>> getStories() => _storiesApi.getStories();

  /// Saves a [story].
  ///
  /// If a [story] with the same id already exists, it will be replaced.
  Future<void> saveStory(Story story) => _storiesApi.saveStory(story);

  /// Deletes the story with the given id.
  ///
  /// If no story with the given id exists, a [StoryNotFoundException] error is
  /// thrown.
  Future<void> deleteStory(String id) => _storiesApi.deleteStory(id);
}
