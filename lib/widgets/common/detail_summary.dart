import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class DetailSummary extends StatelessWidget {
  final String iconAsset;
  final Icon? iconAlternative;
  final String detailTitle;
  final String detailValue;

  const DetailSummary({
    Key? key,
    required this.iconAsset,
    this.iconAlternative,
    required this.detailTitle,
    required this.detailValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (iconAlternative == null)
          Image.asset(
            iconAsset,
            width: 24,
            height: 24,
          ),
        if (iconAlternative != null) iconAlternative!,
        const SizedBox(width: 12),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Text(
                  detailTitle,
                  style: const TextStyle(
                    fontWeight: Constant.mediumWeightText,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                detailValue,
                style: const TextStyle(
                  fontWeight: Constant.mediumWeightText,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
