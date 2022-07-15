// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:relive_web3/app/app.dart';
import 'package:relive_web3/bootstrap.dart';
import 'package:storytelling_repository/storytelling_repository.dart';

void main() {
  const storytellingRepository = StorytellingRepository();
  bootstrap(
    () => const App(
      storytellingRepository: storytellingRepository,
    ),
  );
}
