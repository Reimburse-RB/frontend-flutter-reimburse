import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/form_small_note.dart';

class FormDatePicker extends StatefulWidget {
  const FormDatePicker({
    Key? key,
    this.isEnabled = true,
    this.controllerName,
    this.hintText = '',
    this.placeholder = '',
    this.initialValue,
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
    this.noteStyle = Constant.regularNoteStyle,
  }) : super(key: key);

  final bool isEnabled;
  final TextEditingController? controllerName;
  final String hintText;
  final String placeholder;
  final String? initialValue;
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
  State<FormDatePicker> createState() => _FormDatePickerState();
}

class _FormDatePickerState extends State<FormDatePicker> {
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
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              widget.placeholder,
              textAlign: TextAlign.start,
              style: Constant.mainTitleStyle,
            ),
          ),
        Row(
          children: [
            Flexible(
              child: TextFormField(
                enabled: widget.isEnabled,
                initialValue: widget.initialValue,
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
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: () {
                // DATE PICKER
              },
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: widget.isEnabled ? Constant.green : Constant.grey,
                ),
                child: const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.white,
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
