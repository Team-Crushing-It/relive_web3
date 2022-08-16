import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stories_repository/stories_repository.dart';

part 'capture_story_state.dart';

class CaptureStoryCubit extends Cubit<CaptureStoryState> {
  CaptureStoryCubit(this._repository) : super(const CaptureStoryState());

  final StoriesRepository _repository;

  void saveStory(String path) {
    print(path);
    Story story = Story(filePath: path, tags: ["bra"]);
    _repository.saveStory(story);
    emit(state.copyWith(message: "added a story"));
  }
}
