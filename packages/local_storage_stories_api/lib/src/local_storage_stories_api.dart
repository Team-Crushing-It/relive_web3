import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stories_api/stories_api.dart';

/// {@template local_storage_stories_api}
/// A Flutter implementation of the [StoriesApi] that uses local storage.
/// {@endtemplate}
class LocalStorageStoriesApi extends StoriesApi {
  /// {@macro local_storage_stories_api}
  LocalStorageStoriesApi({
    required SharedPreferences plugin,
  }) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _storyStreamController = BehaviorSubject<List<Story>>.seeded(const []);

  /// The key used for storing the stories locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kStoriesCollectionKey = '__stories_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final storiesJson = _getValue(kStoriesCollectionKey);
    if (storiesJson != null) {
      final stories = List<Map>.from(json.decode(storiesJson) as List)
          .map((jsonMap) => Story.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _storyStreamController.add(stories);
    } else {
      _storyStreamController.add(const []);
    }
  }

  @override
  Stream<List<Story>> getStories() => _storyStreamController.asBroadcastStream();

  @override
  Future<void> saveStory(Story story) {
    final stories = [..._storyStreamController.value];
    final storyIndex = stories.indexWhere((t) => t.id == story.id);
    if (storyIndex >= 0) {
      stories[storyIndex] = story;
    } else {
      stories.add(story);
    }

    _storyStreamController.add(stories);
    return _setValue(kStoriesCollectionKey, json.encode(stories));
  }

  @override
  Future<void> deleteStory(String id) async {
    final stories = [..._storyStreamController.value];
    final storyIndex = stories.indexWhere((t) => t.id == id);
    if (storyIndex == -1) {
      throw StoryNotFoundException();
    } else {
      stories.removeAt(storyIndex);
      _storyStreamController.add(stories);
      return _setValue(kStoriesCollectionKey, json.encode(stories));
    }
  }
}
