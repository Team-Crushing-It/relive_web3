import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relive_web3/app/app.dart';
import 'package:path/path.dart' as path;
import 'package:relive_web3/capture_story/capture_story.dart';
import 'package:relive_web3/capture_story/helper/file_picker.dart';
import 'package:relive_web3/home/home.dart';
import 'package:stories_repository/stories_repository.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CaptureStoryPage extends StatelessWidget {
  const CaptureStoryPage._();

  static Page page() => const SlideRightPage<void>(
        key: ValueKey('capture_oveview_page'),
        child: CaptureStoryPage._(),
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.abc_outlined),
              onPressed: () =>
                  {context.read<HomeCubit>().setPage(CurrentHomePage.overview)},
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: constraints.maxWidth,
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: BlocProvider(
                    create: (_) =>
                        CaptureStoryCubit(context.read<StoriesRepository>()),
                    child: CaptureStoryView(),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class CaptureStoryView extends StatefulWidget {
  CaptureStoryView({Key? key}) : super(key: key);

  @override
  State<CaptureStoryView> createState() => _CaptureStoryViewState();
}

class _CaptureStoryViewState extends State<CaptureStoryView> {
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  XFile? file;
  Future<Widget> playVideo() async {  
    videoPlayerController = VideoPlayerController.file(File(file!.path));
    await videoPlayerController!.initialize();

    final chewieController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        allowFullScreen: false  );
    final Widget playerWidget = Chewie(
      controller: chewieController,
    );
    return playerWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: file == null
          ? const Center(
              child: Text(
                "Capture your story !",
                style: TextStyle(fontSize: 30),
              ),
            )
          : path.extension(file!.path) == ".jpg"
              ? Container(
                  margin: EdgeInsets.zero,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: FileImage(File(file!.path)),
                      fit: BoxFit.cover,
                    ),
                  ),
                  /* add child content here */
                )
              : FutureBuilder(
                  future: playVideo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return snapshot.data as Widget;
                    } else {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: InkWell(
          onLongPress: () async {
            XFile? video = await FilePicker.pickVideo();
            if (video != null)
              setState(() {
                file = video;
                context.read<CaptureStoryCubit>().saveStory(video.path);
              });
          },
          child: FloatingActionButton(
            child: Image.asset('assets/camera.png'),
            backgroundColor: Colors.white.withOpacity(0.5),
            onPressed: () async {
              XFile? photo = await FilePicker.pickImage();
              if (photo != null)
                setState(() {
                  file = photo;
                  context.read<CaptureStoryCubit>().saveStory(photo.path);
                });
            },
          ),
        ),
      ),
    );
  }
}
