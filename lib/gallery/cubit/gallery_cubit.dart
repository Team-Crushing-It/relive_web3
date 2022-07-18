import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:storytelling_repository/storytelling_repository.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit(this._repository) : super(const GalleryState());

  final StorytellingRepository _repository;

}
