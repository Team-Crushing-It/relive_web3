import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storytelling_repository/storytelling_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final StorytellingRepository _repository;

  Future<void> ffmpegTest() async {
    final output = await _repository.test();

    emit(state.copyWith(message: output));

    return;
  }
}
