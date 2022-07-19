import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storytelling_repository/storytelling_repository.dart';

part 'tell_story_state.dart';

class TellStoryCubit extends Cubit<TellStoryState> {
  TellStoryCubit(this._repository) : super(const TellStoryState());

  final StorytellingRepository _repository;

}
