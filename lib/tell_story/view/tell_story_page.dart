import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/tell_story/tell_story.dart';
import 'package:storytelling_repository/storytelling_repository.dart';


class TellStoryPage extends StatelessWidget {
  const TellStoryPage({Key? key}) : super(key: key);


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
                        TellStoryCubit(context.read<StorytellingRepository>()),
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

