import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stories_repository/stories_repository.dart';

part 'edit_story_event.dart';
part 'edit_story_state.dart';

class EditStoryBloc extends Bloc<EditStoryEvent, EditStoryState> {
  EditStoryBloc({
    required StoriesRepository storiesRepository,
    required Story? initialStory,
  })  : _storiesRepository = storiesRepository,
        super(
          EditStoryState(
            initialStory: initialStory,
            id: initialStory?.id ?? '',
            tags: initialStory?.tags ?? [],
          ),
        ) {
    on<EditStoryTagAdded>(_onTagAdded);
    on<EditStorySubmitted>(_onSubmitted);
  }

  final StoriesRepository _storiesRepository;

  void _onTagAdded(
    EditStoryTagAdded event,
    Emitter<EditStoryState> emit,
  ) {
    emit(state.copyWith(newTag: event.tag));
  }

  Future<void> _onSubmitted(
    EditStorySubmitted event,
    Emitter<EditStoryState> emit,
  ) async {
    emit(state.copyWith(status: EditStoryStatus.loading));
    final outputTags = state.initialStory!.tags.map((e) => e).toList();
    outputTags.add(state.newTag);
    final story = state.initialStory!.copyWith(tags: outputTags);

    try {
      await _storiesRepository.saveStory(story);
      emit(state.copyWith(status: EditStoryStatus.success, initialStory: story));
    } catch (e) {
      emit(state.copyWith(status: EditStoryStatus.failure));
    }
  }
}
