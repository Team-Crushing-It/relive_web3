part of 'home_cubit.dart';

enum CurrentHomePage { capture, overview, tell }

class HomeState extends Equatable {
  const HomeState({
    this.page = CurrentHomePage.capture,
  });

  final CurrentHomePage page;

  @override
  List<Object> get props => [page];
}
