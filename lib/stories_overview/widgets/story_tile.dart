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

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 3,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: 50,
          width: 50,
          child: Center(child: Text(story.id!, textAlign: TextAlign.center)),
        ),
      ),
    );
  }
}
