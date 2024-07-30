import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class FormFieldText extends StatefulWidget {
  const FormFieldText({
    Key? key,
    this.isEnabled = true,
    this.controllerName,
    this.hintText = '',
    this.placeholder = '',
    this.initialValue,
    this.readOnly = false,
    this.isObsecure = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.errorText = '',
    this.suffixIcon,
    this.borderColor = Colors.black,
    this.onTap,
    this.onChanged,
    this.prefixIconNote,
    this.note = '',
    this.noteStyle = const TextStyle(
      color: Constant.rejectedStatusColor,
      fontWeight: Constant.lightWeightText,
      fontSize: 12,
    ),
  }) : super(key: key);

  final bool isEnabled;
  final TextEditingController? controllerName;
  final String hintText;
  final String placeholder;
  final String? initialValue;
  final bool readOnly;
  final bool isObsecure;

  final int maxLines;
  final int minLines;

  final TextInputType keyboardType;
  final String errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;

  final Widget? prefixIconNote;
  final String note;
  final TextStyle noteStyle;

  final void Function()? onTap;
  final void Function(String)? onChanged;

  @override
  State<FormFieldText> createState() => _FormFieldTextState();
}

class _FormFieldTextState extends State<FormFieldText> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.placeholder != '')
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 16),
            child: Text(
              widget.placeholder,
              textAlign: TextAlign.start,
              style: Constant.mainTitleStyle,
            ),
          ),
        TextFormField(
          enabled: widget.isEnabled,
          initialValue: widget.initialValue,
          readOnly: widget.readOnly,
          controller: widget.controllerName,
          onChanged: widget.onChanged,
          minLines: widget.minLines,
          keyboardType: widget.keyboardType,
          obscureText: widget.isObsecure,
          maxLines: widget.maxLines,
          onTap: widget.onTap,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 4,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Colors.black,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Constant.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Constant.greenMedium,
              ),
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
          ),
        ),
        if (widget.note.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Row(
              children: [
                if (widget.prefixIconNote != null)
                  Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: widget.prefixIconNote,
                  ),
                Text(
                  widget.note,
                  style: widget.noteStyle,
                ),
              ],
            ),
          )
      ],
    );
  }
}
