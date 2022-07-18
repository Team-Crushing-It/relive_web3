part of 'tell_story_cubit.dart';

class TellStoryState extends Equatable {
  const TellStoryState({
    this.message = 'inital',
  });

  final String message;

  @override
  List<Object> get props => [message];

  TellStoryState copyWith({
    String? message,
  }) {
    return TellStoryState(
      message: message ?? this.message,
    );
  }
}
