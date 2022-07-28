import 'package:flutter/widgets.dart';
import 'package:local_storage_stories_api/local_storage_stories_api.dart';
import 'package:relive_web3/app/app.dart';
import 'package:relive_web3/bootstrap.dart';
import 'package:stories_repository/stories_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final storiesApi = LocalStorageStoriesApi(
    plugin: await SharedPreferences.getInstance(),
  );
  final storiesRepository = StoriesRepository(storiesApi: storiesApi);
  await bootstrap(
    () => App(
      storiesRepository: storiesRepository,
    ),
  );
}
