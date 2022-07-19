part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.message = '',
    this.videos = const [],
  });

  final List<String> videos;
  final String message;

  @override
  List<Object> get props => [videos, message];

  HomeState copyWith({
    List<String>? videos,
    String? message,
  }) {
    return HomeState(
      videos: videos ?? this.videos,
      message: message ?? this.message,
    );
  }
}
