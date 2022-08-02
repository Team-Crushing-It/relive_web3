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
    return BlocListener<EditStoryBloc, EditStoryState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EditStoryStatus.success,
      listener: (context, state) => Navigator.of(context).pop(),
      child: const EditStoryView(),
    );
  }
}

class EditStoryView extends StatelessWidget {
  const EditStoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final status = context.select((EditStoryBloc bloc) => bloc.state.status);
    final isNewStory = context.select(
      (EditStoryBloc bloc) => bloc.state.isNewStory,
    );
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
        backgroundColor: status.isLoadingOrSuccess
            ? fabBackgroundColor.withOpacity(0.5)
            : fabBackgroundColor,
        onPressed: status.isLoadingOrSuccess
            ? null
            : () =>
                context.read<EditStoryBloc>().add(const EditStorySubmitted()),
        child: status.isLoadingOrSuccess
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.check_rounded),
      ),
      body: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: const [_TagsList()],
            ),
          ),
        ),
      ),
    );
  }
}

class _TagsList extends StatelessWidget {
  const _TagsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final state = context.watch<EditStoryBloc>().state;
    final hintText = state.initialStory?.tags ?? '';
    return Text(state.initialStory!.id!);

    // return TextFormField(
    //   key: const Key('editStoryView_tags_textFormList'),
    //   initialValue: state.tags,
    //   decoration: InputDecoration(
    //     enabled: !state.status.isLoadingOrSuccess,
    //     labelText: l10n.editStoryTagsLabel,
    //     hintText: hintText,
    //   ),
    //   maxLength: 300,
    //   maxLines: 7,
    //   inputFormatters: [
    //     LengthLimitingTextInputFormatter(300),
    //   ],
    //   onChanged: (value) {
    //     context.read<EditStoryBloc>().add(EditStoryTagsChanged(value));
    //   },
    // );
  }
}
