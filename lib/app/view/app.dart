import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/home/home.dart';
import 'package:relive_web3/l10n/l10n.dart';
import 'package:stories_repository/stories_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required StoriesRepository storiesRepository,
  })  : _storiesRepository = storiesRepository,
        super(key: key);

  final StoriesRepository _storiesRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _storiesRepository,
      child: const AppView(),
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
      home: const HomePage(),
    );
  }
}
