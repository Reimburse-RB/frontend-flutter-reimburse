import 'package:flutter/material.dart';

class FormDialogString extends StatefulWidget {
  final String placeholder;
  final List<String> options; // Menggunakan List<String>
  final Function(String) onChanged;

  const FormDialogString({
    Key? key,
    required this.placeholder,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FormDialogStringState createState() => _FormDialogStringState();
}

class _FormDialogStringState extends State<FormDialogString> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.options.isNotEmpty ? widget.options.first : null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.placeholder.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4, bottom: 12),
            child: Text(
              widget.placeholder,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: widget.options.map((option) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedOption = option; // Set pilihan yang dipilih
                  widget.onChanged(selectedOption!); // Kirim ke callback
                });
              },
              child: Row(
                children: [
                  Radio<String>(
                    value: option,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value; // Set pilihan yang dipilih
                        widget.onChanged(selectedOption!); // Kirim ke callback
                      });
                    },
                  ),
                  Text(option),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
