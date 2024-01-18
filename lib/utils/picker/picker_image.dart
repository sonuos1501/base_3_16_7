import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constants/colors.dart';

class PickImagaCustom {
  static Future<String?> pickMedia({
    required bool isGallery,
    // Future<CroppedFile?> Function(File file)? cropImage,
  }) async {
    final source = isGallery ? ImageSource.gallery : ImageSource.camera;
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);

      if (pickedFile == null) {
        return null;
      }

      return cropCustomImage(path: pickedFile.path)
          .then((value) => value?.path);
    } on Exception catch (e) {
      throw Exception(e);
    }
  }

  static Future<CroppedFile?> cropCustomImage({required String path}) async =>
      ImageCropper().cropImage(
        aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
        sourcePath: path,
        uiSettings: [iosUiSettings(), androidUiSettings()],
        // aspectRatioPresets: [
        //   CropAspectRatioPreset.original,
        //   CropAspectRatioPreset.square,
        //   CropAspectRatioPreset.ratio3x2,
        //   CropAspectRatioPreset.ratio4x3,
        // ],
      );

  static IOSUiSettings iosUiSettings() => IOSUiSettings(
        aspectRatioLockEnabled: true,
        showCancelConfirmationDialog: true,
        title: 'Crop Image',
      );

  static AndroidUiSettings androidUiSettings() => AndroidUiSettings(
        toolbarTitle: 'Crop Image',
        toolbarColor: AppColors.red,
        toolbarWidgetColor: AppColors.white,
        lockAspectRatio: false,
      );
}

  //   Future<File> cropPredefinedImage(File imageFile) async =>
  //     await ImageCropper.cropImage(
  //       sourcePath: imageFile.path,
  //       aspectRatioPresets: [
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.ratio4x3,
  //       ],
  //       androidUiSettings: androidUiSettingsLocked(),
  //       iosUiSettings: iosUiSettingsLocked(),
  //     );

  // IOSUiSettings iosUiSettingsLocked() => IOSUiSettings(
  //       aspectRatioLockEnabled: false,
  //       resetAspectRatioEnabled: false,
  //     );

  // AndroidUiSettings androidUiSettingsLocked() => AndroidUiSettings(
  //       toolbarTitle: 'Crop Image',
  //       toolbarColor: Colors.red,
  //       toolbarWidgetColor: Colors.white,
  //       initAspectRatio: CropAspectRatioPreset.original,
  //       lockAspectRatio: false,
  //     );
