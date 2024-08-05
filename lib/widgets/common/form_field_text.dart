import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/form_small_note.dart';

class FormFieldText extends StatefulWidget {
  const FormFieldText({
    Key? key,
    this.isEnabled = true,
    this.controllerName,
    this.hintText = '',
    this.placeholder = '',
    this.initialValue,
    this.isObsecure = false,
    this.isCost = false,
    this.maxLines = 1,
    this.minLines = 1,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.errorText = '',
    this.suffixIcon,
    this.borderColor = Colors.black,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onFocusLost,
    this.prefixIconNote,
    this.note = '',
    this.noteStyle = Constant.regularNoteStyle,
  }) : super(key: key);

  final bool isEnabled;
  final TextEditingController? controllerName;
  final String hintText;
  final String placeholder;
  final String? initialValue;
  final bool isObsecure;
  final bool isCost;

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
  final void Function()? onEditingComplete;
  final void Function()? onFocusLost; // Tambahkan ini

  @override
  State<FormFieldText> createState() => _FormFieldTextState();
}

class _FormFieldTextState extends State<FormFieldText> {
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      if (widget.onFocusLost != null) {
        widget.onFocusLost!();
      }
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.placeholder != '')
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              widget.placeholder,
              textAlign: TextAlign.start,
              style: Constant.mainTitleStyle,
            ),
          ),
        Row(
          children: [
            if (widget.isCost)
              Container(
                margin: const EdgeInsets.only(right: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: widget.isEnabled ? Colors.black : Constant.grey,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Text(
                  'Rp',
                  style: TextStyle(
                    fontWeight: Constant.boldText,
                  ),
                ),
              ),
            Flexible(
              child: TextFormField(
                focusNode: _focusNode, // Tambahkan ini
                enabled: widget.isEnabled,
                initialValue: widget.initialValue,
                controller: widget.controllerName,
                onChanged: widget.onChanged,
                minLines: widget.minLines,
                keyboardType: widget.keyboardType,
                obscureText: widget.isObsecure,
                maxLines: widget.maxLines,
                onTap: widget.onTap,
                onEditingComplete: widget.onEditingComplete,
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
            ),
          ],
        ),
        if (widget.note.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: FormSmallNote(
              note: widget.note,
              noteTextStyle: widget.noteStyle,
              prefixIcon: widget.prefixIconNote,
            ),
          )
      ],
    );
  }
}
