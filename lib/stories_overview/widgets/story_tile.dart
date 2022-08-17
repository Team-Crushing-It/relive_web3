import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:stories_repository/stories_repository.dart';
import 'package:video_player/video_player.dart';
import 'package:path/path.dart' as path;

class StoryTile extends StatelessWidget {
  StoryTile({
    Key? key,
    required this.story,
    this.onTap,
  }) : super(key: key);

  final Story story;
  final VoidCallback? onTap;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  Future<Widget> playVideo(String path) async {
    videoPlayerController = VideoPlayerController.file(File(path));
    await videoPlayerController!.initialize();

    final chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        allowFullScreen: false,
        looping: false,
        autoPlay: true,
        showControls: true);
    final Widget playerWidget = Chewie(
      controller: chewieController,
    );
    return playerWidget;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: path.extension(story.filePath!) == ".jpg"
            ? Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(story.filePath!)),
                    fit: BoxFit.contain,
                  ),
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
                height: 300,
                width: 300,
              )
            : Container(
                padding: EdgeInsets.all(0),
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
                height: 300,
                width: 300,
                child: FutureBuilder(
                    future: playVideo(story.filePath!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return snapshot.data as Widget;
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    }),
              ),
      ),
    );
  }
}
