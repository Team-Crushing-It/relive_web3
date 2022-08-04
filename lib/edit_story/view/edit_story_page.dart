import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:relive_web3/edit_story/edit_story.dart';
import 'package:relive_web3/l10n/l10n.dart';
import 'package:stories_repository/stories_repository.dart';

class EditStoryPage extends StatelessWidget {
  const EditStoryPage({Key? key}) : super(key: key);

  static Route<void> route({Story? initialStory}) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EditStoryBloc(
          storiesRepository: context.read<StoriesRepository>(),
          initialStory: initialStory,
        ),
        child: const EditStoryPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const EditStoryView();
  }
}

class EditStoryView extends StatelessWidget {
  const EditStoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final state = context.watch<EditStoryBloc>().state;

    final theme = Theme.of(context);
    final floatingActionButtonTheme = theme.floatingActionButtonTheme;
    final fabBackgroundColor = floatingActionButtonTheme.backgroundColor ??
        theme.colorScheme.secondary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.editStoryEditAppBarTitle,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: l10n.editStorySaveButtonTooltip,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32)),
        ),
        backgroundColor: fabBackgroundColor,
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (context) => SimpleDialog(
              title: const Text('Add new tag'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    onChanged: (value) {
                      context.read<EditStoryBloc>().add(
                            EditStoryTagAdded(value),
                          );
                    },
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    context
                        .read<EditStoryBloc>()
                        .add(const EditStorySubmitted());
                    Navigator.pop(context);
                  },
                  child: const Text('Add Tag'),
                ),
              ],
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(state.initialStory!.id!),
                if (state.initialStory!.tags.isNotEmpty)
                  for (final tag in state.initialStory!.tags)
                    ListTile(
                      title: Text(tag),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
