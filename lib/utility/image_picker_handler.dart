import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:ui' as ui;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reimburse_rb/utility/image_picker_dialog.dart';
import 'package:mime/mime.dart';

import 'constant.dart';

class ImagePickerHandler {
  ImagePickerDialog? imagePicker;
  AnimationController? animationController;
  ImagePickerListener? imagePickerListener;

  ImagePickerHandler(this.imagePickerListener, this.animationController);

  void init(BuildContext context) {
    imagePicker = ImagePickerDialog(
      context: context,
      imagePickerHandler: this,
      animationController: animationController,
    );
  }

  openCamera() async {
    imagePicker?.dismissDialog();
    XFile? images = await ImagePicker().pickImage(
      source: ImageSource.camera,
    );
    if (images != null) {
      final File image = File(images.path);
      cropImage(image);
    }
  }

  openGallery() async {
    imagePicker?.dismissDialog();
    XFile? images = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (images != null) {
      final File image = File(images.path);

      String base64Image = base64Encode(image.readAsBytesSync());
      log('===> imagepicker base64 uncropped $base64Image');

      cropImage(image);
    }
  }

  Future cropImage(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      // compressQuality: 100,
      compressFormat: ImageCompressFormat.jpg,
      sourcePath: image.path,
      // aspectRatioPresets: [
      //   CropAspectRatioPreset.square,
      //   CropAspectRatioPreset.ratio3x2,
      //   CropAspectRatioPreset.original,
      //   CropAspectRatioPreset.ratio4x3,
      //   CropAspectRatioPreset.ratio16x9,
      // ],
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Sesuaikan Gambar',
          toolbarColor: Constant.greenDark,
          toolbarWidgetColor: Colors.white,
          activeControlsWidgetColor: Constant.greenDark,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(
          minimumAspectRatio: 1.0,
        ),
      ],
      maxWidth: 2000,
      maxHeight: 2000,
    );
    if (croppedFile != null) {
      File files = File(croppedFile.path);
      checkImageSize(files);
      imagePickerListener?.userImage(files);
    }
  }

  void showDialog(BuildContext context) {
    imagePicker?.getImage(context);
  }
}

mixin ImagePickerListener {
  void userImage(File image);
}

void checkImageSize(File file) async {
  // Detect MIME type
  final mimeType = lookupMimeType(file.path);

  // Log the file's MIME type
  log('File MIME type: $mimeType');

  // Check if the file is an image based on its MIME type
  if (mimeType != null && mimeType.startsWith('image/')) {
    final imageBytes = await file.readAsBytes();

    // Decode the image
    final codec = await ui.instantiateImageCodec(imageBytes);
    final frame = await codec.getNextFrame();
    final image = frame.image;

    // Get width and height
    final width = image.width;
    final height = image.height;

    // Get file size in bytes
    final fileSizeInBytes = await file.length();
    final fileSizeInKB = fileSizeInBytes / 1024; // Size in KB
    final fileSizeInMB = fileSizeInKB / 1024; // Size in MB

    // Log image details
    log('Image width: $width Image height: $height');
    log('Image file size: ${fileSizeInBytes} bytes (${fileSizeInKB.toStringAsFixed(2)} KB, ${fileSizeInMB.toStringAsFixed(2)} MB)');
    log('Image type: $mimeType');
  } else {
    log('The file is not an image. MIME type: $mimeType');
  }
}
