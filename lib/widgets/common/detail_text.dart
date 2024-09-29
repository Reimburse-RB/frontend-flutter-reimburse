import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';

class DetailText extends StatelessWidget {
  const DetailText({
    super.key,
    required this.title,
    this.textValue = '',
    this.costValue,
    this.valueColor = Colors.black,
    this.valueBackgroundEnabled = false,
    this.valueBackgroundColor = Colors.transparent,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.margin = const EdgeInsets.only(top: 20),
    this.isHorizontal = false,
    this.horizontalBorderEnabled = true,
  });

  final String title;
  final String textValue;
  final double? costValue;
  final Color valueColor;
  final bool valueBackgroundEnabled;
  final Color valueBackgroundColor;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool isHorizontal;
  final bool horizontalBorderEnabled;

  Widget verticalDetail(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: Constant.boldText),
          ),
          const SizedBox(height: 8),
          Container(
            padding:
                valueBackgroundEnabled ? EdgeInsets.symmetric(vertical: 8, horizontal: 16) : null,
            decoration: BoxDecoration(
              color: valueBackgroundEnabled ? valueBackgroundColor : null,
              borderRadius: valueBackgroundEnabled ? BorderRadius.circular(16) : null,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (costValue != null)
                  Text(
                    Helper(context: context).formatCurrency(amount: costValue!),
                    style: TextStyle(color: valueColor, fontSize: 16),
                  ),
                if (textValue.isNotEmpty)
                  Text(
                    textValue,
                    style: TextStyle(color: valueColor, fontSize: 16),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget horizontalDetail(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(border: Border(bottom: BorderSide(width: 0.5))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontWeight: Constant.boldText, fontSize: 12),
              ),
            ),
            const SizedBox(width: 12),
            Flexible(
              child: Container(
                padding: valueBackgroundEnabled
                    ? EdgeInsets.symmetric(vertical: 8, horizontal: 16)
                    : null,
                decoration: BoxDecoration(
                  color: valueBackgroundEnabled ? valueBackgroundColor : null,
                  borderRadius: valueBackgroundEnabled ? BorderRadius.circular(16) : null,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (costValue != null)
                      Text(
                        Helper(context: context).formatCurrency(amount: costValue!),
                        style: TextStyle(color: valueColor, fontSize: 14),
                      ),
                    if (textValue.isNotEmpty)
                      Text(
                        textValue,
                        style: TextStyle(color: valueColor, fontSize: 14),
                      ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return (textValue.isEmpty && costValue == null)
        ? Container()
        : isHorizontal
            ? horizontalDetail(context)
            : verticalDetail(context);
  }
}
