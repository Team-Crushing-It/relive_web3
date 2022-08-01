import 'package:authentication_repository/authentication_repository.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/app/bloc/app_bloc.dart';
import 'package:relive_web3/home/view/home_page.dart';
import 'package:relive_web3/l10n/l10n.dart';
import 'package:relive_web3/login/login.dart';
import 'package:stories_repository/stories_repository.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}

class App extends StatelessWidget {
  const App({
    Key? key,
    required StoriesRepository storiesRepository,
    required AuthenticationRepository authenticationRepository,
  })  : _storiesRepository = storiesRepository,
        _authenticationRepository = authenticationRepository,
        super(key: key);

  final StoriesRepository _storiesRepository;
  final AuthenticationRepository _authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _authenticationRepository),
        RepositoryProvider.value(value: _storiesRepository),
      ],
      child: BlocProvider(
        create: (_) => AppBloc(
          authenticationRepository: _authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: FlowBuilder(
        onGeneratePages: onGenerateAppViewPages,
        state: context.select<AppBloc, AppStatus>(
          (bloc) => bloc.state.status,
        ),
      ),
    );
  }
}
