import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/employee/card_receipt_image.dart';

class ListHorizontalDetailReceiptImage extends StatelessWidget {
  final String title;
  final List<ItemAttachmentData> listAttachment;
  final int paddingSize;

  const ListHorizontalDetailReceiptImage({
    Key? key,
    required this.title,
    required this.listAttachment,
    this.paddingSize = 24,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (listAttachment.isEmpty)
        ? Container()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: paddingSize.toDouble()),
                child: Text(
                  title,
                  style: Constant.secondTitleStyle,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 240,
                child: ListView.builder(
                  padding: EdgeInsets.only(left: paddingSize.toDouble(), right: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: listAttachment.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: CardReceiptImage(
                        imageUrl: listAttachment[index].image ?? '',
                        onTapImage: () {
                          Helper(context: context).viewPhoto(source: listAttachment[index].image);
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
