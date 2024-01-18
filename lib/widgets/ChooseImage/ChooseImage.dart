// ignore_for_file: inference_failure_on_function_return_type, inference_failure_on_function_invocation, avoid_catches_without_on_clauses, avoid_dynamic_calls, inference_failure_on_instance_creation, use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';
import 'package:theshowplayer/di/action_method_locator.dart';
import 'package:theshowplayer/utils/bottom_sheet/BottomSheetUtil.dart';
import 'package:theshowplayer/utils/locale/app_localization.dart';
import 'package:theshowplayer/widgets/bottom_sheet/bottom_sheet_strikethrough.dart';
import 'package:theshowplayer/widgets/divider/divider.dart';

import '../../constants/app_theme.dart';
import '../../utils/utils.dart';

export 'dart:io';

typedef VoidOnChooseImage = void Function(File image);

class ChooseImage {

  ChooseImage({
    required this.context,
    this.onActionTakePicture,
    this.isCrop = false,
    this.isMultiImage = false,
    this.onChooseImage,
    this.onChooseMultiImage,
    this.onHideLoading,
    this.onShowLoading,
  });
  //Loading request permission
  Function? onShowLoading;
  Function? onActionTakePicture;
  Function? onHideLoading;
  VoidOnChooseImage? onChooseImage;
  Function(List<File> file)? onChooseMultiImage;

  final BuildContext context;
  final bool isCrop;
  final bool isMultiImage;

  Future<void> show() async {
    await BottomSheetUtil.buildBaseButtonSheet(
      context,
      color: Colors.transparent,
      child: BottomSheetStrikeThrough(
        children: <Widget>[
          InkWell(
            onTap: () {
              navigation.pop();
              _chooseImage(ImageSource.camera);
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'profile_mg9'.tr(context),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: AppThemeData.regular,
                ),
              ),
            ),
          ),
          _divider(context),
          InkWell(
            onTap: () {
              navigation.pop();
              if (onActionTakePicture != null) {
                onActionTakePicture?.call();
              } else {
                _chooseImage(ImageSource.gallery);
              }
            },
            child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Text(
                'profile_mg10'.tr(context),
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Theme.of(context).colorScheme.surfaceVariant,
                  fontWeight: AppThemeData.regular,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _divider(BuildContext context) => CustomDivider(height: 0.5, color: Theme.of(context).colorScheme.onTertiaryContainer);

  Future<File?> compressFile(File file) async {
    final filePath = file.absolute.path;

    // Create output file path
    // eg:- "Volume/VM/abcd_out.jpeg"
    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, lastIndex);
    final outPath = '${splitted}_out${filePath.substring(lastIndex)}';
    final result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      outPath,
      quality: 20,
    );

    return result;
  }

  Future<void> _chooseImage(ImageSource imageSource) async {
    if (onShowLoading != null) {
      onShowLoading?.call();
    }
    final osVersion = Platform.operatingSystemVersion;
    debugPrint('osVersion $osVersion');
    if (isMultiImage && imageSource == ImageSource.gallery && Platform.isIOS && Utils.getFirstVersionOS() < 14) {
      XFile? xFile;
      try {
        final picker = ImagePicker();
        xFile = await picker.pickImage(source: imageSource);
        if (xFile == null) {
          onHideLoading?.call();
          return;
        }
      } catch (ex) {
        onHideLoading?.call();
        return;
      }

      if (isCrop) {
        await Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhotoPickerAndCropPage(
            file: File(xFile!.path),
            onCropImage: (imageFileCrop) {
              onChooseImage?.call(imageFileCrop);
              onChooseMultiImage?.call([imageFileCrop]);
            },
          ),
        ),);
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();
        onChooseImage?.call(File(xFile.path));
        onChooseMultiImage?.call([File(xFile.path)]);
      }
    } else if (isMultiImage && imageSource == ImageSource.gallery) {
      List<XFile>? listXFile;
      try {
        final picker = ImagePicker();
        listXFile = await picker.pickMultiImage(imageQuality: 20);
        if (listXFile.isEmpty) {
          onHideLoading?.call();
          return;
        }
      } catch (ex) {
        onHideLoading?.call();
        return;
      }
      await Future.delayed(const Duration(milliseconds: 100));
      onHideLoading?.call();
      final listFile = <File>[];
      for (final item in listXFile) {
        listFile.add(File(item.path));
      }
      onChooseMultiImage?.call(listFile);
    } else {
      XFile? xFile;
      try {
        final picker = ImagePicker();
        xFile = await picker.pickImage(source: imageSource);
        if (xFile == null) {
          onHideLoading?.call();
          return;
        }
      } catch (ex) {
        onHideLoading?.call();
        return;
      }

      if (isCrop) {
        await Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PhotoPickerAndCropPage(
            file: File(xFile!.path),
            onCropImage: (imageFileCrop) {
              onChooseImage?.call(imageFileCrop);
              onChooseMultiImage?.call([imageFileCrop]);
            },
          ),
        ),);
      } else {
        await Future.delayed(const Duration(milliseconds: 100));
        onHideLoading?.call();
        onChooseImage?.call(File(xFile.path));
        onChooseMultiImage?.call([File(xFile.path)]);
      }
    }
  }
}

typedef VoidOnCropImage = void Function(File fileCrop);

class PhotoPickerAndCropPage extends StatefulWidget {

  const PhotoPickerAndCropPage({super.key, required this.file, this.onCropImage});
  final File file;
  final VoidOnCropImage? onCropImage;

  @override
  State<PhotoPickerAndCropPage> createState() => _PhotoPickerAndCropPageState();
}

class _PhotoPickerAndCropPageState extends State<PhotoPickerAndCropPage> {
  final cropKey = GlobalKey<CropState>();
  File? _file;
  File? _sample;
  // File? _lastCropped;

  @override
  void initState() {
    super.initState();
    _file = widget.file;
    _sample = widget.file;
    log('file: ${_file?.path}');

    //_createImageCrop();
  }

  @override
  void dispose() {
    super.dispose();
    //_file?.delete();
    //_sample?.delete();
    //_lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          color: Colors.black,
          child: _sample == null ? _buildOpeningImage() : _buildCroppingImage(),
        ),
      ),
    );
  }

  Widget _buildOpeningImage() {
    return Center(child: _buildOpenImage());
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop.file(
            _sample!,
            key: cropKey,
            aspectRatio: 1,
            maximumScale: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                onPressed: _cropImage,
                child: const Text(
                  'Lưu',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              //_buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildOpenImage() {
    return MaterialButton(
      onPressed: () {},
      child: const Text(
        'Open Image',
        style: TextStyle(color: Colors.white),
      ),
      //onPressed: () => _openImage(),
    );
  }

  //  11:37:34.062
  //  11:37:40.088
  //
  //  Future<void> _createImageCrop() async {
  //    final sample = await ImageCrop.sampleImage(
  //      file: _file,
  //      preferredSize: context.size.longestSide.ceil(),
  //    );
  //
  //    _sample?.delete();
  //    _file?.delete();
  //  }
  //
  //  Future<void> _openImage() async {
  //    final file = await ImagePicker.pickImage(source: ImageSource.gallery);
  //    final sample = await ImageCrop.sampleImage(
  //      file: file,
  //      preferredSize: context.size.longestSide.ceil(),
  //    );
  //
  //    _sample?.delete();
  //    _file?.delete();
  //
  //    setState(() {
  //      _sample = sample;
  //      _file = file;
  //    });
  //  }

  Future<void> _cropImage() async {
    // final scale = cropKey.currentState?.scale;
    final area = cropKey.currentState?.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
//    final sample = await ImageCrop.sampleImage(
//      file: _file,
//      preferredSize: (2000 / scale).round(),
//    );
    await Future.delayed(const Duration(milliseconds: 100));
    log('_file?.path: ${_file?.path}');
    final file = await ImageCrop.cropImage(
      file: _file!,
      area: area,
      scale: 1,
    );
    log('file.path: ${file.path}${file.path}');
    //await new Future.delayed(const Duration(milliseconds: 200));

    // await new Future.delayed(const Duration(milliseconds: 200));
    // print(sample);
    // this.widget.file.delete();
    // sample.delete();

    // _lastCropped?.delete();
    // _lastCropped = file;

    Navigator.pop(context);
    if (widget.onCropImage != null) {
      widget.onCropImage?.call(file);
    }
    // debugPrint('$file');
  }
}
