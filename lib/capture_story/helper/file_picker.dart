import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class FilePicker {
  static Future<XFile?> pickImage() async {
    final _picker = ImagePicker();
    final photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      File imageFile = File(photo.path);
      final appDocDir = await getApplicationDocumentsDirectory();
      print(appDocDir.path);
      final appDocPath = appDocDir.path;
      final fileName = path.basename(imageFile.path);
      final localImage = await imageFile.copy('$appDocPath/$fileName');
      print(localImage.path);
    }
    return photo;
  }

  static Future<XFile?> pickVideo() async {
    final _picker = ImagePicker();
    final video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      File imageFile = File(video.path);
      final appDocDir = await getApplicationDocumentsDirectory();
      print(appDocDir.path);
      final appDocPath = appDocDir.path;
      final fileName = path.basename(imageFile.path);
      final localVideo = await imageFile.copy('$appDocPath/$fileName');
      print(localVideo.path);
    }
    return video;
  }
}
