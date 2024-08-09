import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/employee/card_receipt_image.dart';

class FormImageAttachment extends StatelessWidget {
  final String title;
  final VoidCallback? onTapAddImage;
  final double paddingSize;
  final SubmissionFormViewModel viewModel;

  const FormImageAttachment({
    Key? key,
    required this.title,
    required this.viewModel,
    this.onTapAddImage,
    this.paddingSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Constant.secondTitleStyle,
              ),
              const SizedBox(height: 12),
              DottedBorder(
                padding: const EdgeInsets.all(4),
                dashPattern: const [10, 5],
                color: Constant.grey,
                borderType: BorderType.RRect,
                radius: const Radius.circular(16),
                child: InkWell(
                  onTap: onTapAddImage,
                  splashColor: Colors.green,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 24,
                      horizontal: 24,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.image,
                          color: Constant.green,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          userProvider.selectedReimbursementCategory
                                      ?.categoryReimbursementId ==
                                  1
                              ? 'Tambahkan Gambar Bukti Pendukung (struk, kuitansi, resep, dsb)'
                              : 'Tambahkan Gambar Bukti Pendukung (struk, kuitansi, lokasi, dsb)',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Constant.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (viewModel.listAttachmentImageFile.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 16),
            height: 240,
            child: ListView.builder(
              padding: EdgeInsets.only(left: paddingSize, right: 12),
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.listAttachmentImageFile.length,
              itemBuilder: (context, index) {
                File item = viewModel.listAttachmentImageFile[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CardReceiptImage(
                    isImageFile: true,
                    imageFile: item,
                    onTapImage: () {
                      Helper(context: context).viewPhoto(
                        source: item,
                        isImageFile: true,
                      );
                    },
                    onCancel: () {
                      viewModel.removeImage(index: index);
                    },
                  ),
                );
              },
            ),
          )
      ],
    );
  }
}
