import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relive_web3/home/home.dart';
import 'package:stories_repository/stories_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Test'), centerTitle: true),
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
                    create: (_) => HomeCubit(
                      context.read<StoriesRepository>(),
                    ),
                    child: const HomeView(),
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

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final vids = context.watch<HomeCubit>().state.videos;
    return Scaffold(
      body: Column(
        children: [
          // Text(test),
          TextButton(
            onPressed: () {
              context.read<HomeCubit>().ffmpegTest();
            },
            child: Text('TEXT BUTTON'),
          ),
          // ListView.builder(
          //   itemCount: vids.length,
          //   itemBuilder: (context, index) {
          //     return ListTile(
          //       title: Text(vids[index]),
          //     );
          //   },
          // )
        ],
      ),
    );
  }
}
