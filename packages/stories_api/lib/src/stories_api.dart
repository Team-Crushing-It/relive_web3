import 'package:stories_api/stories_api.dart';

/// {@template todos_api}
/// The interface for an API that provides access to a list of todos.
/// {@endtemplate}
abstract class StoriesApi {
  /// {@macro todos_api}
  const StoriesApi();

  /// Provides a [Stream] of all todos.
  Stream<List<Story>> getStories();

  /// Saves a [todo].
  ///
  /// If a [todo] with the same id already exists, it will be replaced.
  Future<void> saveStory(Story todo);

  /// Deletes the todo with the given id.
  ///
  /// If no todo with the given id exists, a [StoryNotFoundException] error is
  /// thrown.
  Future<void> deleteStory(String id);
}

/// Error thrown when a [Story] with a given id is not found.
class StoryNotFoundException implements Exception {}
