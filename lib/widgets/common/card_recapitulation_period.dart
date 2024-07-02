import 'package:flutter/material.dart';

class CardRecapitulationPeriod extends StatelessWidget {
  const CardRecapitulationPeriod({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Colors.grey.shade400,
            ),
          ),
        ),
        child: Text(
          'Mei 2023',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
