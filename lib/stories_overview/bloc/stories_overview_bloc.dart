import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:relive_web3/stories_overview/stories_overview.dart';
import 'package:stories_repository/stories_repository.dart';

part 'stories_overview_event.dart';
part 'stories_overview_state.dart';

class StoriesOverviewBloc
    extends Bloc<StoriesOverviewEvent, StoriesOverviewState> {
  StoriesOverviewBloc({
    required StoriesRepository storiesRepository,
  })  : _storiesRepository = storiesRepository,
        super(const StoriesOverviewState()) {
    on<StoriesOverviewSubscriptionRequested>(_onSubscriptionRequested);
    on<StoriesOverviewStoryDeleted>(_onStoryDeleted);
    on<StoriesOverviewUndoDeletionRequested>(_onUndoDeletionRequested);
    on<StoriesOverviewFilterChanged>(_onFilterChanged);
  }

  final StoriesRepository _storiesRepository;

  Future<void> _onSubscriptionRequested(
    StoriesOverviewSubscriptionRequested event,
    Emitter<StoriesOverviewState> emit,
  ) async {
    emit(state.copyWith(status: () => StoriesOverviewStatus.loading));

    await emit.forEach<List<Story>>(
      _storiesRepository.getStories(),
      onData: (stories) => state.copyWith(
        status: () => StoriesOverviewStatus.success,
        stories: () => stories,
      ),
      onError: (_, __) => state.copyWith(
        status: () => StoriesOverviewStatus.failure,
      ),
    );
  }

  Future<void> _onStoryDeleted(
    StoriesOverviewStoryDeleted event,
    Emitter<StoriesOverviewState> emit,
  ) async {
    emit(state.copyWith(lastDeletedStory: () => event.story));
    await _storiesRepository.deleteStory(event.story.id!);
  }

  Future<void> _onUndoDeletionRequested(
    StoriesOverviewUndoDeletionRequested event,
    Emitter<StoriesOverviewState> emit,
  ) async {
    assert(
      state.lastDeletedStory != null,
      'Last deleted story can not be null.',
    );

    final story = state.lastDeletedStory!;
    emit(state.copyWith(lastDeletedStory: () => null));
    await _storiesRepository.saveStory(story);
  }

  void _onFilterChanged(
    StoriesOverviewFilterChanged event,
    Emitter<StoriesOverviewState> emit,
  ) {
    emit(state.copyWith(filter: () => event.filter));
  }
}
