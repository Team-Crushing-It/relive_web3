import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/capture_story/capture_story.dart';
import 'package:relive_web3/edit_story/edit_story.dart';
import 'package:relive_web3/home/home.dart';
import 'package:relive_web3/stories_overview/stories_overview.dart';
import 'package:relive_web3/tell_story/tell_story.dart';

List<Page> onGenerateHomePages(
  HomeState state,
  List<Page<dynamic>> pages,
) {
  if (state.page == CurrentHomePage.overview) {
    return [StoriesOverviewPage.page()];
  }
  if (state.page == CurrentHomePage.capture) {
    return [CaptureStoryPage.page()];
  }
   if (state.page == CurrentHomePage.tell) {
    return [TellStoryPage.page()];
  }

  return pages;
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(
        key: ValueKey('home_page'),
        child: HomePage(),
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlowBuilder(
        onGeneratePages: onGenerateHomePages,
        state: context.select<HomeCubit, HomeState>(
          (cubit) => cubit.state,
        ),
      ),
    );
  }
}
