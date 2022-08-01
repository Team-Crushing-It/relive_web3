import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:local_storage_stories_api/local_storage_stories_api.dart';
import 'package:relive_web3/app/app.dart';
import 'package:relive_web3/bootstrap.dart';
import 'package:relive_web3/firebase_options.dart';
import 'package:stories_repository/stories_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storiesApi = LocalStorageStoriesApi(
    plugin: await SharedPreferences.getInstance(),
  );
  final storiesRepository = StoriesRepository(storiesApi: storiesApi);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final authenticationRepository = AuthenticationRepository();
  await authenticationRepository.user.first;

  await bootstrap(
    () => App(
      authenticationRepository: authenticationRepository,
      storiesRepository: storiesRepository,
    ),
  );
}
