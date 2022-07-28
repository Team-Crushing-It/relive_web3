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
    on<EditStoryTagsChanged>(_onTagsChanged);
    on<EditStorySubmitted>(_onSubmitted);
  }

  final StoriesRepository _storiesRepository;


  void _onTagsChanged(
    EditStoryTagsChanged event,
    Emitter<EditStoryState> emit,
  ) {
    emit(state.copyWith(tags: event.tags));
  }

  Future<void> _onSubmitted(
    EditStorySubmitted event,
    Emitter<EditStoryState> emit,
  ) async {
    // emit(state.copyWith(status: EditStoryStatus.loading));
    // final story = (state.initialStory ?? Story(title: '')).copyWith(
    //   title: state.title,
    //   description: state.description,
    // );

    // try {
    //   await _storiesRepository.saveStory(story);
    //   emit(state.copyWith(status: EditStoryStatus.success));
    // } catch (e) {
    //   emit(state.copyWith(status: EditStoryStatus.failure));
    // }
  }
}
