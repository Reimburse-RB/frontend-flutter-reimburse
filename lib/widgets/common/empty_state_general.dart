import 'package:flutter/material.dart';

class EmptyStateGeneral extends StatelessWidget {
  const EmptyStateGeneral({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/empty_state/img-empty-state.png',
            width: MediaQuery.of(context).size.width / 2.5,
          ),
          const SizedBox(height: 12),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Belum ada',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: ' data untuk ditampilkan saat ini',
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
