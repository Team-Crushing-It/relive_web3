import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/home/home.dart';
import 'package:relive_web3/l10n/l10n.dart';
import 'package:relive_web3/tell_story/tell_story.dart';
import 'package:stories_repository/stories_repository.dart';

class TellStoryPage extends StatelessWidget {
  const TellStoryPage._();

  static Page page() => const MaterialPage<void>(
        key: ValueKey('capture_oveview_page'),
        child: TellStoryPage._(),
      );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.storiesOverviewAppBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () =>
                {context.read<HomeCubit>().setPage(CurrentHomePage.overview)},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: constraints.maxWidth,
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(36),
                  child: BlocProvider(
                    create: (_) =>
                        TellStoryCubit(context.read<StoriesRepository>()),
                    child: const TellStoryView(),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TellStoryView extends StatelessWidget {
  const TellStoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
