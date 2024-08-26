import 'dart:async';

import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/image_picker_handler.dart';

class ImagePickerDialog extends StatelessWidget {
  final ImagePickerHandler? imagePickerHandler;
  final AnimationController? animationController;
  final BuildContext context;

  final Animation<double>? drawerContentsOpacity;
  final Animation<Offset>? drawerDetailsPosition;

  ImagePickerDialog({
    super.key,
    required this.context,
    this.imagePickerHandler,
    this.animationController,
  })  : drawerContentsOpacity = CurvedAnimation(
          parent: ReverseAnimation(animationController!),
          curve: Curves.fastOutSlowIn,
        ),
        drawerDetailsPosition = Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(CurvedAnimation(
          parent: animationController,
          curve: Curves.fastOutSlowIn,
        ));

  void getImage(BuildContext context) {
    if (animationController == null ||
        drawerDetailsPosition == null ||
        drawerContentsOpacity == null) {
      return;
    }
    animationController?.forward();
    showDialog(
      context: context,
      builder: (BuildContext context) => SlideTransition(
        position: drawerDetailsPosition!,
        child: FadeTransition(
          opacity: ReverseAnimation(drawerContentsOpacity!),
          child: this,
        ),
      ),
    );
  }

  void dispose() {
    animationController?.dispose();
  }

  Timer startTime() {
    var _duration = const Duration(milliseconds: 200);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pop(context);
  }

  void dismissDialog() {
    animationController?.reverse();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        type: MaterialType.transparency,
        child: Opacity(
          opacity: 1.0,
          child: Container(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () => imagePickerHandler?.openCamera(),
                  child: roundedButton(
                    "Camera",
                    const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    Constant.greenDark,
                    const Color(0xFFFFFFFF),
                    icon: const Icon(
                      IconlyLight.camera,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => imagePickerHandler?.openGallery(),
                  child: roundedButton(
                    "Gallery",
                    const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    Constant.greenDark,
                    const Color(0xFFFFFFFF),
                    icon: const Icon(
                      IconlyLight.image,
                      color: Colors.white,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => dismissDialog(),
                  child: roundedButton(
                    "Cancel",
                    const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    Colors.white,
                    Constant.greenDark,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget roundedButton(
    String buttonLabel,
    EdgeInsets margin,
    Color bgColor,
    Color textColor, {
    Icon? icon,
  }) {
    return Container(
      margin: margin,
      padding: const EdgeInsets.all(15.0),
      alignment: FractionalOffset.center,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Container(
              margin: const EdgeInsets.only(right: 8),
              child: icon,
            ),
          Text(
            buttonLabel,
            style: TextStyle(
              color: textColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
