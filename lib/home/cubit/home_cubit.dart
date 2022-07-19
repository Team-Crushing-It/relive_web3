import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:stories_repository/stories_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final StoriesRepository _repository;

  Future<void> ffmpegTest() async {
    final output =  _repository.getStories();

    // emit(state.copyWith(videos: output));

    return;
  }
}
