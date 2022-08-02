import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/capture_story/capture_story.dart';
import 'package:relive_web3/home/home.dart';
import 'package:stories_repository/stories_repository.dart';

class CaptureStoryPage extends StatelessWidget {
  const CaptureStoryPage._();

  static Page page() => const SlideRightPage<void>(
        key: ValueKey('capture_oveview_page'),
        child: CaptureStoryPage._(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.abc_outlined),
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
                        CaptureStoryCubit(context.read<StoriesRepository>()),
                    child: const CaptureStoryView(),
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

class CaptureStoryView extends StatelessWidget {
  const CaptureStoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
