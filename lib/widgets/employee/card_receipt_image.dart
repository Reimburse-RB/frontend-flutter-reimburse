import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardReceiptImage extends StatelessWidget {
  final bool isImageFile;
  final String imageUrl;
  final File? imageFile;
  final VoidCallback? onTapImage;
  final VoidCallback? onCancel;

  const CardReceiptImage({
    Key? key,
    this.isImageFile = false,
    this.imageFile,
    this.imageUrl = '',
    this.onTapImage,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (imageUrl.isNotEmpty || imageFile != null)
        ? AspectRatio(
            aspectRatio: 9 / 16,
            child: Stack(
              children: [
                Positioned.fill(
                  child: InkWell(
                    onTap: onTapImage,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                          width: 0.5,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: isImageFile && imageFile != null
                            ? Image.file(
                                imageFile!,
                                fit: BoxFit.cover,
                              )
                            : CachedNetworkImage(
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
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
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                      ),
                    ),
                  ),
                ),
                if (onCancel != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: InkWell(
                      onTap: onCancel,
                      child: const Icon(
                        Icons.cancel,
                        color: Constant
                            .rejectedStatusColor, // Ubah sesuai kebutuhan, misalnya Constant.green
                      ),
                    ),
                  ),
              ],
            ),
          )
        : Container();
  }
}
