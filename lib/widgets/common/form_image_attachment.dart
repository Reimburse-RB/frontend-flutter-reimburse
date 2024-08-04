import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';

class FormImageAttachment extends StatelessWidget {
  final String title;
  // final List<String> listImageUrl;
  final double paddingSize;

  const FormImageAttachment({
    Key? key,
    required this.title,
    // required this.listImageUrl,
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
                  onTap: () {},
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
                          userProvider.selectedReimbursementCategory?.categoryReimbursementId == 1
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
        const SizedBox(height: 8),
        // SizedBox(
        //   height: 240,
        //   child: ListView.builder(
        //     padding: EdgeInsets.only(left: paddingSize, right: 12),
        //     scrollDirection: Axis.horizontal,
        //     itemCount: listImageUrl.length,
        //     itemBuilder: (context, index) {
        //       return Padding(
        //         padding: const EdgeInsets.only(right: 12),
        //         child: CardReceiptImage(
        //           imageUrl: listImageUrl[index],
        //         ),
        //       );
        //     },
        //   ),
        // )
      ],
    );
  }
}
