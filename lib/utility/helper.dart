import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:reimburse_rb/models/common/modal_data.dart';
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
    bool isSuccess = true,
    required String message,
    Color backgroundColor = Constant.acceptedStatusIconColor,
    Color messageColor = Colors.white,
    Color borderColor = Colors.white,
    Widget? icon,
  }) {
    Flushbar(
      icon: icon,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: const EdgeInsets.fromLTRB(24, 24, 24, 72),
      flushbarPosition: FlushbarPosition.TOP,
      borderColor: borderColor,
      borderRadius: BorderRadius.circular(20),
      message: message,
      messageColor: messageColor,
      duration: const Duration(seconds: 3),
      backgroundColor: isSuccess ? backgroundColor : Constant.rejectedStatusColor,
    ).show(context);
  }

  SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.25, vertical: 10),
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(color: Colors.black45, borderRadius: BorderRadius.circular(4)),
        child: Text(
          content,
          style: const TextStyle(
            color: Colors.red,
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
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

  Future<bool> handleWillPop(BuildContext context, bool isEditing) async {
    if (isEditing) {
      await Helper(context: context).alertClose(
        title: 'Konfirmasi',
        message: 'Apakah Anda yakin akan keluar dari halaman ini? Perubahan tidak akan disimpan.',
        context: context,
        firstButtonOnTap: () {
          Navigator.pop(context);
        },
        secondButtonOnTap: () {
          Navigator.pop(context);
        },
      );
      return false; // return false if alertClose is shown
    } else {
      Navigator.pop(context);
      return true; // return true if not editing
    }
  }

  alertClose({
    required String title,
    required String message,
    required BuildContext context,
    String firstButtonLabel = 'Lanjutkan',
    String secondButtonLabel = 'Batal',
    AlertType? alertType,
    required Function() firstButtonOnTap,
    required Function() secondButtonOnTap,
  }) {
    Alert(
      context: context,
      type: alertType,
      style: const AlertStyle(
        isCloseButton: false,
        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        titlePadding: EdgeInsets.only(bottom: 8, top: 10),
      ),
      title: title,
      content: Text(
        message,
        style: const TextStyle(fontSize: 14),
      ),
      buttons: [
        DialogButton(
          radius: BorderRadius.circular(20),
          child: Text(
            firstButtonLabel,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: firstButtonOnTap,
          color: Constant.green,
        ),
        DialogButton(
          radius: BorderRadius.circular(20),
          child: Text(
            secondButtonLabel,
            style: const TextStyle(
              color: Constant.green,
            ),
          ),
          onPressed: secondButtonOnTap,
          color: Colors.white,
          border: Border.all(
            width: 1,
            color: Constant.green,
          ),
        ),
      ],
    ).show();
  }

  // ImageProvider _getImageProvider(String source) {
  //   if (source.startsWith('http')) {
  //     return NetworkImage(source);
  //   } else {
  //     return MemoryImage(base64Decode(source));
  //   }
  // }

  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatCurrency.format(amount);
  }

  void showModalReimbursement({
    required BuildContext context,
    required String title,
    required List<ModalRegularData> listOptions,
  }) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight:
                  MediaQuery.of(context).size.height * 0.8, // max height 80% of screen height
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: listOptions.length,
                    itemBuilder: (context, index) {
                      final option = listOptions[index];
                      return GestureDetector(
                        onTap: option.onTap,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            option.text,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
