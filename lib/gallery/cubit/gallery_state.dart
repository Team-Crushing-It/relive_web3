part of 'gallery_cubit.dart';

class GalleryState extends Equatable {
  const GalleryState({
    this.message = 'inital',
  });

  final String message;

  @override
  List<Object> get props => [message];

  GalleryState copyWith({
    String? message,
  }) {
    return GalleryState(
      message: message ?? this.message,
    );
  }
}
