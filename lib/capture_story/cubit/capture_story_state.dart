part of 'capture_story_cubit.dart';

class CaptureStoryState extends Equatable {
  const CaptureStoryState({
    this.message = 'inital',
  });

  final String message;

  @override
  List<Object> get props => [message];

  CaptureStoryState copyWith({
    String? message,
  }) {
    return CaptureStoryState(
      message: message ?? this.message,
    );
  }
}
