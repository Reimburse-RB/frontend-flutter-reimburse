import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Helper {
  Helper({required this.context});

  final BuildContext context;

  // launchURL(url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     if (url.contains("youtube")) {
  //       final regex = RegExp(r'.*\?v=(.+?)($|[\&])',
  //           caseSensitive: false, multiLine: false);
  //       if (regex.hasMatch(url)) {
  //         String videoId = regex.firstMatch(url)!.group(1) as String;
  //         ("videoId = $videoId");
  //         return Navigator.of(context)
  //             .pushNamed('/universalWebviewPage', arguments: videoId);
  //       } else {
  //         ("Cannot parse $url");
  //         return false;
  //       }
  //     }
  //     return await launchUrl(Uri.parse(url),
  //         mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void showToast({
    required String message,
    Color backgroundColor = Constant.greenMedium,
    Color messageColor = Colors.white,
    Color borderColor = Colors.white,
    Widget? icon,
  }) {
    Flushbar(
      icon: icon,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 72),
      flushbarPosition: FlushbarPosition.BOTTOM,
      borderColor: borderColor,
      borderRadius: BorderRadius.circular(8),
      message: message,
      messageColor: messageColor,
      duration: const Duration(seconds: 3),
      backgroundColor: backgroundColor,
    ).show(context);
  }

  // Future viewPhoto({required String source, required String heroTag}) async {
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight,
  //     DeviceOrientation.landscapeLeft,
  //     DeviceOrientation.portraitDown,
  //     DeviceOrientation.portraitUp,
  //   ]);

  //   return Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (ctx) => Scaffold(
  //         appBar: AppBar(
  //           backgroundColor: Colors.black,
  //           leading: IconButton(
  //             icon: const Icon(
  //               Icons.chevron_left,
  //               size: 36,
  //               color: Colors.white,
  //             ),
  //             onPressed: () => Navigator.of(context).pop(),
  //           ),
  //         ),
  //         body: Hero(
  //           tag: heroTag,
  //           child: Container(
  //             constraints: BoxConstraints.expand(
  //               height: MediaQuery.of(context).size.height,
  //             ),
  //             child: PhotoView(
  //               imageProvider: _getImageProvider(
  //                   source), // Gunakan fungsi untuk memilih imageProvider
  //               loadingBuilder: (context, event) {
  //                 if (event == null) {
  //                   return const Center(
  //                     child: Text("Loading"),
  //                   );
  //                 }

  //                 final value = event.cumulativeBytesLoaded /
  //                     (event.expectedTotalBytes ?? event.cumulativeBytesLoaded);

  //                 final percentage = (100 * value).floor();
  //                 return Center(
  //                   child: Text("$percentage%"),
  //                 );
  //               },
  //             ),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // alertClose({
  //   required String title,
  //   required String message,
  //   required BuildContext context,
  //   String firstButtonLabel = 'Lanjutkan',
  //   String secondButtonLabel = 'Batal',
  //   required Function() firstButtonOnTap,
  //   required Function() secondButtonOnTap,
  // }) {
  //   Alert(
  //     context: context,
  //     // type: AlertType.info,
  //     style: AlertStyle(
  //       isCloseButton: false,
  //       titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //       titlePadding: EdgeInsets.only(bottom: 8, top: 10),
  //     ),
  //     title: title,
  //     content: Text(
  //       message,
  //       style: TextStyle(fontSize: 14),
  //     ),
  //     buttons: [
  //       DialogButton(
  //         radius: BorderRadius.circular(16),
  //         child: Text(
  //           firstButtonLabel,
  //           style: TextStyle(
  //             color: Colors.white,
  //           ),
  //         ),
  //         onPressed: firstButtonOnTap,
  //         color: Constant.greenDark,
  //       ),
  //       DialogButton(
  //         radius: BorderRadius.circular(16),
  //         child: Text(
  //           secondButtonLabel,
  //           style: TextStyle(
  //             color: Constant.greenDark,
  //           ),
  //         ),
  //         onPressed: secondButtonOnTap,
  //         color: Colors.white,
  //         border: Border.all(
  //           width: 1,
  //           color: Constant.greenDark,
  //         ),
  //       ),
  //     ],
  //   ).show();
  // }

  // ImageProvider _getImageProvider(String source) {
  //   if (source.startsWith('http')) {
  //     return NetworkImage(source);
  //   } else {
  //     return MemoryImage(base64Decode(source));
  //   }
  // }
}
