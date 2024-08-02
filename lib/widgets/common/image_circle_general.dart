import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:reimburse_rb/utility/constant.dart';

class ImageCircleGeneral extends StatelessWidget {
  final double size;
  final String? imageUrl;
  final String? fallbackUrl;
  final VoidCallback? onTap;

  const ImageCircleGeneral({
    Key? key,
    required this.size,
    this.imageUrl,
    this.fallbackUrl,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
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
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(fallbackUrl ?? Constant.randomImageUrl),
                ),
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }
}
