// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:relive_web3/app/app.dart';
import 'package:relive_web3/bootstrap.dart';
import 'package:stories_repository/stories_repository.dart';
import 'package:local_storage_stories_api/local_storage_stories_api.dart';

void main() async {
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
