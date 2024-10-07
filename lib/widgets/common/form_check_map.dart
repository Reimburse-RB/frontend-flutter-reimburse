import 'package:flutter/material.dart';

class FormCheckMap extends StatefulWidget {
  final String placeholder;
  final List<Map<String, dynamic>> options;
  final Function(List) onChanged;

  const FormCheckMap({
    Key? key,
    required this.placeholder,
    required this.options,
    required this.onChanged,
  }) : super(key: key);

  @override
  _FormCheckMapState createState() => _FormCheckMapState();
}

class _FormCheckMapState extends State<FormCheckMap> {
  List<Map<String, dynamic>> selectedOptions = [];
  List listSelectedOptionIds = [];

  @override
  void initState() {
    super.initState();
    // Centang semua opsi secara default
    selectedOptions = List.from(widget.options);
    listSelectedOptionIds = widget.options.map((item) {
      return item['id_option'];
    }).toList();
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
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        Column(
          children: widget.options.map((option) {
            return CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(option['text_option']),
              value: selectedOptions.contains(option),
              checkboxShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              onChanged: (bool? value) {
                setState(() {
                  if (value == true) {
                    selectedOptions.add(option);
                    listSelectedOptionIds.add(option['id_option']);
                  } else {
                    selectedOptions.remove(option);
                    listSelectedOptionIds.remove(option['id_option']);
                  }
                  widget.onChanged(listSelectedOptionIds);
                });
              },
            );
          }).toList(),
        ),
      ],
    );
  }
}
