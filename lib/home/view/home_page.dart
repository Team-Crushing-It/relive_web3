import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/edit_story/edit_story.dart';
import 'package:relive_web3/home/home.dart';
import 'package:relive_web3/stories_overview/stories_overview.dart';
import 'package:relive_web3/tell_story/tell_story.dart';

List<Page> onGenerateHomePages(
  CurrentHomePage page,
  List<Page<dynamic>> pages,
) {
  if (page == CurrentHomePage.overview) {
    return [StoriesOverviewPage.page()];
  }

  return pages;
}

class HomePage extends StatelessWidget {
  const HomePage._();

  static Page page() => const MaterialPage<void>(
        key: ValueKey('home_page'),
        child: HomePage._(),
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
        state: context.select<HomeCubit, CurrentHomePage>(
          (cubit) => cubit.state.page,
        ),
      ),
    );
  }
}
