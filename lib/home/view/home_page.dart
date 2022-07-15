import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relive_web3/home/home.dart';
import 'package:storytelling_repository/storytelling_repository.dart';


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
                    create: (_) =>
                        HomeCubit(context.read<StorytellingRepository>()),
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

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<Directory?>? _appDocumentsDirectory;

  void _requestAppDocumentsDirectory() {
    setState(() {
      _appDocumentsDirectory = getApplicationDocumentsDirectory();
    });
  }

  @override
  Widget build(BuildContext context) {
    final test = context.watch<HomeCubit>().state.message;
    return Scaffold(
        body: Column(
      children: [
        Text(test),
        TextButton(
          onPressed: () {
            context.read<HomeCubit>().ffmpegTest();
          },
          child: Text("TEXT BUTTON"),
        )
      ],
    ));
  }
}
