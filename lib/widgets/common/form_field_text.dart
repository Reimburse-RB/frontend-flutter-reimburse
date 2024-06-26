import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';

class FormFieldText extends StatefulWidget {
  const FormFieldText({
    Key? key,
    required this.controllerName,
    this.hintText = '',
    this.placeholder = '',
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
  }) : super(key: key);

  final TextEditingController controllerName;
  final String hintText;
  final String placeholder;
  final bool readOnly;
  final bool isObsecure;

  final int maxLines;
  final int minLines;

  final TextInputType keyboardType;
  final String errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color borderColor;
  final void Function()? onTap;

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
            margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
            child: Text(
              widget.placeholder,
              textAlign: TextAlign.start,
              style: Constant.mainTitleStyle,
            ),
          ),
        const SizedBox(height: 12),
        TextFormField(
            readOnly: widget.readOnly,
            controller: widget.controllerName,
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
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Constant.greenDark,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Constant.green,
                ),
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
            )),
      ],
    );
  }
}
