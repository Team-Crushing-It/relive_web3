import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stories_repository/stories_repository.dart';

part 'tell_story_state.dart';

class TellStoryCubit extends Cubit<TellStoryState> {
  TellStoryCubit(this._repository) : super(const TellStoryState());

  final StoriesRepository _repository;

}
