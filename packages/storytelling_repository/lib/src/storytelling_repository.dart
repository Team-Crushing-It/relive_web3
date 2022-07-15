import 'dart:io';

import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

/// {@template storytelling_repository}
/// Sharing stories in new way the we'vealways shared them
/// {@endtemplate}
class StorytellingRepository {
  /// {@macro storytelling_repository}
  const StorytellingRepository();

  Future<File> videoFromAsset(String asset) async {
    final byteData = await rootBundle.load(asset);
    final bytes = byteData.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();

    final assetName = asset.split('/').last;
    final tempFile = File('${tempDir.path}/$assetName')
      ..createSync(recursive: true);
    await tempFile.writeAsBytes(bytes);
    return tempFile;
  }

  Future<String> test() async {
    ReturnCode? returnCode;

    final output = await videoFromAsset('assets/test2.mp4');

    // print(output.path);

    final tempDir = await getTemporaryDirectory();
    final appDir = await getApplicationDocumentsDirectory();

    appDir
      ..list(recursive: true, followLinks: false)
          .listen((FileSystemEntity entity) {
        print(entity.path);
      });

    await FFmpegKit.execute(
            '-i ${output.path} -c:v mpeg4 ${appDir.path}/test4.mp4')
        .then((session) async {
      returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        print('success');
        appDir
          ..list(recursive: true, followLinks: false)
              .listen((FileSystemEntity entity) {
            print(entity.path);
          });
      } else if (ReturnCode.isCancel(returnCode)) {
        print('iscancel');
      } else {
        print('error');
        print(returnCode);
      }
    });
    return returnCode.toString();
  }
}
