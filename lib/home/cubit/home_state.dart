part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.message = 'inital',
  });

  final String message;

  @override
  List<Object> get props => [message];

  HomeState copyWith({
    String? message,
  }) {
    return HomeState(
      message: message ?? this.message,
    );
  }
}

// class HomeInitial extends HomeState {}
