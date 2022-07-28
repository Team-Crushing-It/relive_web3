import 'package:flutter/material.dart';
import 'package:stories_repository/stories_repository.dart';

class StoryTile extends StatelessWidget {
  const StoryTile({
    Key? key,
    required this.story,
    this.onTap,
  }) : super(key: key);

  final Story story;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return const SizedBox(height: 50, width: 50);
  }
}
