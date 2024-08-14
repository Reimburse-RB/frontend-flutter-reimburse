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
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  final String title;
  final String textValue;
  final double? costValue;
  final Color valueColor;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return (textValue.isEmpty && costValue == null)
        ? Container()
        : Container(
            padding: padding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: Constant.boldText),
                ),
                const SizedBox(height: 8),
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
          );
  }
}
