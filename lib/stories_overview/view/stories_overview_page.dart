import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/capture_story/capture_story.dart';
import 'package:relive_web3/edit_story/view/edit_story_page.dart';
import 'package:relive_web3/home/home.dart';
import 'package:relive_web3/l10n/l10n.dart';
import 'package:relive_web3/stories_overview/stories_overview.dart';
import 'package:relive_web3/stories_overview/widgets/custom_app_bar.dart';
import 'package:stories_repository/stories_repository.dart';

class StoriesOverviewPage extends StatelessWidget {
  const StoriesOverviewPage._();

  static Page page() => const FadePage<void>(
        key: ValueKey('stories_oveview_page'),
        child: StoriesOverviewPage._(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StoriesOverviewBloc(
        storiesRepository: context.read<StoriesRepository>(),
      )..add(const StoriesOverviewSubscriptionRequested()),
      child: const StoriesOverviewView(),
    );
  }
}

class StoriesOverviewView extends StatelessWidget {
  const StoriesOverviewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeCubit>().setPage(CurrentHomePage.tell);
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
      appBar: CustomAppBar(
        children: [
          IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () =>
                {context.read<HomeCubit>().setPage(CurrentHomePage.capture)},
          ),
          IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () =>
                {context.read<HomeCubit>().setPage(CurrentHomePage.capture)},
          ),
          IconButton(
            icon: const Icon(Icons.ac_unit),
            onPressed: () =>
                {context.read<HomeCubit>().setPage(CurrentHomePage.capture)},
          ),
        ],
      ),
      body: MultiBlocListener(
        listeners: [
          BlocListener<StoriesOverviewBloc, StoriesOverviewState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == StoriesOverviewStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.storiesOverviewErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
          BlocListener<StoriesOverviewBloc, StoriesOverviewState>(
            listenWhen: (previous, current) =>
                previous.lastDeletedStory != current.lastDeletedStory &&
                current.lastDeletedStory != null,
            listener: (context, state) {
              final deletedStory = state.lastDeletedStory!;
              final messenger = ScaffoldMessenger.of(context);
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text(
                      l10n.storiesOverviewStoryDeletedSnackbarText(
                        deletedStory.id!,
                      ),
                    ),
                    action: SnackBarAction(
                      label: l10n.storiesOverviewUndoDeletionButtonText,
                      onPressed: () {
                        messenger.hideCurrentSnackBar();
                        context
                            .read<StoriesOverviewBloc>()
                            .add(const StoriesOverviewUndoDeletionRequested());
                      },
                    ),
                  ),
                );
            },
          ),
        ],
        child: BlocBuilder<StoriesOverviewBloc, StoriesOverviewState>(
          builder: (context, state) {
            if (state.stories.isEmpty) {
              if (state.status == StoriesOverviewStatus.loading) {
                return const Center(child: CupertinoActivityIndicator());
              } else if (state.status != StoriesOverviewStatus.success) {
                return const SizedBox();
              } else {
                return Center(
                  child: Text(
                    l10n.storiesOverviewEmptyText,
                    style: Theme.of(context).textTheme.caption,
                  ),
                );
              }
            }

            return CupertinoScrollbar(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: [
                  for (final story in state.filteredStories)
                    StoryTile(
                      story: story,
                      onTap: () {
                        print(state.filteredStories);
                        print('tapped');
                        Navigator.of(context).push(
                          EditStoryPage.route(initialStory: story),
                        );
                      },
                    ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
