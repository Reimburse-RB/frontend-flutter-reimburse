import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reimburse_rb/utility/image_picker_dialog.dart';

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
    XFile? images = await ImagePicker().pickImage(source: ImageSource.camera);
    if (images != null) {
      final File image = File(images.path);
      cropImage(image);
    }
  }

  openGallery() async {
    imagePicker?.dismissDialog();
    XFile? images = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (images != null) {
      final File image = File(images.path);
      cropImage(image);
    }
  }

  Future cropImage(File image) async {
    final croppedFile = await ImageCropper().cropImage(
      // compressQuality: 100,
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
      maxWidth: 512,
      maxHeight: 512,
    );
    if (croppedFile != null) {
      File files = File(croppedFile.path);
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
