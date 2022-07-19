import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:relive_web3/home/home.dart';
import 'package:relive_web3/l10n/l10n.dart';
import 'package:storytelling_repository/storytelling_repository.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required StorytellingRepository storytellingRepository,
  })  : _storytellingRepository = storytellingRepository,
        super(key: key);

  final StorytellingRepository _storytellingRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _storytellingRepository,
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
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomePage(),
    );
  }
}
