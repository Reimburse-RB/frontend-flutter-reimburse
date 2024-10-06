import 'dart:developer';
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/pdf_generator/api/pdf_api.dart';
import 'package:reimburse_rb/utility/pdf_generator/api/pdf_recapitulation_api.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Helper {
  Helper({required this.context});

  final BuildContext context;

  showToast({
    bool isSuccess = true,
    required String? message,
    Color messageColor = Colors.white,
    int seconds = 3,
    EdgeInsets margin = const EdgeInsets.fromLTRB(24, 24, 24, 72),
    Widget? customIcon,
    bool enableIcon = true,
  }) {
    Flushbar(
      icon: isSuccess
          ? Icon(
              Icons.check_circle_rounded,
              color: Constant.acceptedStatusIconColor,
            )
          : Icon(
              Icons.cancel_rounded,
              color: Colors.red.shade400,
            ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      margin: margin,
      flushbarPosition: FlushbarPosition.TOP,
      borderColor: isSuccess ? Constant.greenLight : Colors.red.shade400,
      borderRadius: BorderRadius.circular(20),
      message: message ?? Constant.defaultErrorMessage,
      messageColor: messageColor,
      duration: Duration(seconds: seconds),
      backgroundColor: Colors.grey.shade800,
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

  Future viewPhoto({
    required source,
    String heroTag = '',
    bool isImageFile = false,
  }) async {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(
                Icons.chevron_left,
                size: 36,
                color: Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Hero(
            tag: heroTag,
            child: Container(
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
              ),
              child: PhotoView(
                imageProvider: _getImageProvider(
                  source: source,
                  isImageFile: isImageFile,
                ),
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(Constant.imageErrorAsset);
                },
                loadingBuilder: (context, event) {
                  if (event == null) {
                    return const Center(
                      child: Text("Loading"),
                    );
                  }

                  final value = event.cumulativeBytesLoaded /
                      (event.expectedTotalBytes ?? event.cumulativeBytesLoaded);

                  final percentage = (100 * value).floor();
                  return Center(
                    child: Text("$percentage%"),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> handleWillPop(BuildContext context, bool isEditing) async {
    if (isEditing) {
      await Helper(context: context).alertClose(
        title: 'Anda Yakin?',
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

  alertUnverifiedAccount() {
    final userProvider = context.read<UserProvider>();

    alertClose(
      alertType: AlertType.warning,
      title: 'Warning',
      message: userProvider.isAdmin
          ? Constant.warningUnverifiedAdminAccount
          : Constant.warningUnverifiedEmployeeAccount,
      context: context,
      firstButtonLabel: 'Kembali',
      firstButtonOnTap: () {
        Navigator.pop(context);
      },
    );
  }

  alertClose({
    required String title,
    required String message,
    required BuildContext context,
    String firstButtonLabel = 'Lanjutkan',
    String secondButtonLabel = 'Batal',
    AlertType? alertType,
    required Function() firstButtonOnTap,
    Function()? secondButtonOnTap,
  }) {
    Alert(
      context: context,
      type: alertType,
      style: const AlertStyle(
        isCloseButton: true,
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
          radius: BorderRadius.circular(12),
          child: Text(
            firstButtonLabel,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          onPressed: firstButtonOnTap,
          color: Constant.green,
          border: Border.all(
            width: 1.5,
            color: Constant.green,
          ),
        ),
        if (secondButtonOnTap != null)
          DialogButton(
            radius: BorderRadius.circular(12),
            child: Text(
              secondButtonLabel,
              style: const TextStyle(
                color: Constant.green,
              ),
            ),
            onPressed: secondButtonOnTap,
            color: Colors.white,
            border: Border.all(
              width: 1.5,
              color: Constant.green,
            ),
          ),
      ],
    ).show();
  }

  Future<bool?> showCustomDialog({
    String title = 'Anda Yakin?',
    String message =
        'Apakah Anda yakin akan keluar dari halaman ini? Perubahan tidak akan disimpan.',
    required BuildContext context,
    String firstButtonLabel = 'Batal',
    String secondButtonLabel = 'Lanjutkan',
    Function()? firstButtonOnTap,
    Function()? secondButtonOnTap,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(firstButtonLabel),
              onPressed: firstButtonOnTap ??
                  () {
                    Navigator.pop(context, false);
                  },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: Text(secondButtonLabel),
              onPressed: secondButtonOnTap ??
                  () {
                    Navigator.pop(context, true);
                  },
            ),
          ],
        );
      },
    );
  }

  ImageProvider _getImageProvider({required source, bool isImageFile = false}) {
    if (isImageFile && source is File) {
      return FileImage(source);
    } else if (source is String && source.startsWith('http')) {
      return NetworkImage(source);
    } else {
      return AssetImage(Constant.imageErrorAsset);
    }
  }

  String formatCurrency({
    required double amount,
    String symbol = 'Rp ',
    int decimalDigits = 2,
  }) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: symbol,
      decimalDigits: decimalDigits,
    );
    return formatCurrency.format(amount);
  }

  Color getStatusColor({required int? statusId}) {
    return statusId == Constant.waitingStatusId
        ? Constant.waitingStatusColor
        : statusId == Constant.processStatusId
            ? Constant.processStatusTextColor
            : statusId == Constant.acceptedStatusId
                ? Constant.acceptedStatusTextColor
                : statusId == Constant.rejectedStatusId
                    ? Constant.rejectedStatusColor
                    : Constant.grey;
  }

  String getStatusAsset({required int? statusId}) {
    return statusId == Constant.waitingStatusId
        ? Constant.waitingStatusAsset
        : statusId == Constant.processStatusId
            ? Constant.processStatusAsset
            : statusId == Constant.acceptedStatusId
                ? Constant.acceptedStatusAsset
                : statusId == Constant.rejectedStatusId
                    ? Constant.rejectedStatusAsset
                    : '';
  }

  Future<DateTime?> onChangeDate({
    required BuildContext context,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    final DateTime now = DateTime.now();
    final DateTime defaultFirstDate = firstDate ?? now.subtract(const Duration(days: 30));
    final DateTime defaultLastDate = lastDate ?? now;
    final DateTime defaultInitialDate = initialDate ?? now;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: defaultInitialDate,
      firstDate: defaultFirstDate,
      lastDate: defaultLastDate,
    );

    return pickedDate;
  }

  Future<void> generateAndOpenPdfFormatAll({
    required List<ItemUserReimburseData> listRecapitulation,
    required bool isRangePicked,
  }) async {
    try {
      final pdfFile = await PdfRecapitulationApi(context: context).generatePdfAllRecap(
        listRecapitulation: listRecapitulation,
        isRangePicked: isRangePicked,
      );
      log('Generated PDF: $pdfFile');
      await PdfApi.openFile(pdfFile);
    } catch (e) {
      log('Error generating PDF: $e');
    }
  }

  Future<void> generateAndOpenPdfFormatDetail({
    required DetailReimburseData detailReimburseData,
  }) async {
    try {
      final pdfFile = await PdfRecapitulationApi(context: context).generatePdfDetail(
        detailReimburseData: detailReimburseData,
      );
      log('Generated PDF: $pdfFile');
      await PdfApi.openFile(pdfFile);
    } catch (e) {
      log('Error generating PDF: $e');
    }
  }
}
