import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reimburse_rb/utility/constant.dart';

class ImageCircleGeneral extends StatelessWidget {
  final double size;
  final bool isEditing;
  final bool isImageFile;
  final File? imageFile;
  final String? imageUrl;
  final String? fallbackUrl;
  final VoidCallback? onTap;

  const ImageCircleGeneral({
    Key? key,
    this.isEditing = false,
    this.isImageFile = false,
    this.imageFile,
    required this.size,
    this.imageUrl,
    this.fallbackUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          (isImageFile && imageFile != null)
              ? Container(
                  width: size,
                  height: size,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(width: 2, color: Constant.greenDark),
                  ),
                  child: ClipOval(
                    child: Image.file(
                      imageFile!,
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              : CachedNetworkImage(
                  width: size,
                  height: size,
                  imageUrl: imageUrl ?? '',
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(width: 2, color: Constant.greenDark),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(image: imageProvider),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) => const Center(
                    child: SpinKitWaveSpinner(
                      color: Constant.greenDark,
                      duration: Duration(
                        milliseconds: 2000,
                      ),
                      curve: Curves.linear,
                      waveColor: Constant.greenMedium,
                    ),
                  ),
                  errorWidget: (context, url, error) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(width: 2, color: Constant.greenDark),
                      ),
                      child: ClipOval(
                        child: Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
                          child: Image.asset(Constant.imageEmptyProfileAsset),
                        ),
                      ),
                    );
                  },
                ),
          if (isEditing)
            Container(
              width: size - 8,
              height: size - 8,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6), // Background color with opacity
                shape: BoxShape.circle,
              ),
              child: IconButton(
                icon: const Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 24,
                ),
                onPressed: onTap,
              ),
            ),
        ],
      ),
    );
  }
}
