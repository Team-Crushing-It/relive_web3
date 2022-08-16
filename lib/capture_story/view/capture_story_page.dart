import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:relive_web3/app/app.dart';
import 'package:path/path.dart' as Path;
import 'package:relive_web3/capture_story/capture_story.dart';
import 'package:relive_web3/home/home.dart';
import 'package:stories_repository/stories_repository.dart';

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
  XFile? file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.zero,
        decoration: file == null
            ? null
            : BoxDecoration(
                image: DecorationImage(
                  image: FileImage(File(file!.path)),
                  fit: BoxFit.cover,
                ),
              ),
        child: file == null
            ? const Center(
                child: Text(
                  "Capture a video !",
                  style: TextStyle(fontSize: 30),
                ),
              )
            : null /* add child content here */,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: FloatingActionButton(
          child: Image.asset('assets/camera.png'),
          backgroundColor: Colors.white.withOpacity(0.5),
          onPressed: () async {
            final _picker = ImagePicker();
            final photo = await _picker.pickImage(source: ImageSource.camera);
            File imageFile = File(photo!.path);

            if (photo != null) {
              final appDocDir = await getApplicationDocumentsDirectory();
              print(appDocDir.path);
              final appDocPath = appDocDir.path;
              final fileName = Path.basename(imageFile.path);
              final localImage = await imageFile.copy('$appDocPath/$fileName');
              print(localImage.path);
              setState(() {
                file = photo;
                context.read<CaptureStoryCubit>().saveStory(photo.path);
              });
            }
          },
        ),
      ),
    );
  }
}
