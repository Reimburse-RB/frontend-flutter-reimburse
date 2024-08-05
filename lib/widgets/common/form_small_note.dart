import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/utility/constant.dart';

class FormSmallNote extends StatelessWidget {
  const FormSmallNote({
    super.key,
    required this.note,
    this.prefixIcon,
    this.noteTextStyle = Constant.regularNoteStyle,
  });

  final String note;
  final Widget? prefixIcon;
  final TextStyle noteTextStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (prefixIcon != null)
          Container(
            margin: EdgeInsets.only(right: 12),
            child: prefixIcon,
          ),
        Flexible(
          child: Text(
            note,
            style: noteTextStyle,
          ),
        ),
      ],
    );
  }
}
