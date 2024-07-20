import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardReceiptImage extends StatelessWidget {
  final String imageUrl;
  final VoidCallback? onCancel;

  const CardReceiptImage({
    Key? key,
    required this.imageUrl,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Stack(
        children: [
          Positioned.fill(
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
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
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
    );
  }
}
