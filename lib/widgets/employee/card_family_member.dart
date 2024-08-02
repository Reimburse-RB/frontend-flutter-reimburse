import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reimburse_rb/screens/employee/profile/profile_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/form_dropdown_map.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';

class CardFamilyMember extends StatelessWidget {
  final ProfileViewModel viewModel;
  final int memberIndex;
  final Map<String, dynamic>? status;
  final String name;
  final List<Map<String, dynamic>> listStatusOption;
  final bool isActiveDeleteButton;

  const CardFamilyMember({
    Key? key,
    required this.viewModel,
    required this.memberIndex,
    this.status,
    required this.name,
    required this.listStatusOption,
    this.isActiveDeleteButton = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Anggota Keluarga ${memberIndex + 1}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green[900],
                  ),
                ),
                if (isActiveDeleteButton && viewModel.isEditing)
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.green[900]),
                    onPressed: () {
                      viewModel.removeFamilyMember(index: memberIndex);
                    },
                  ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Status',
              style: TextStyle(
                fontWeight: Constant.boldText,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            FormDropdownMap(
              hintText: 'Pilih Status Keluarga',
              items: listStatusOption,
              value: status,
              onChanged: (viewModel.isEditing)
                  ? (newValue) {
                      if (newValue != null) {
                        viewModel.changeFamilyStatus(index: memberIndex, newStatus: newValue);
                        log('current status $newValue ${newValue['id']}${newValue['text']}');
                      }
                    }
                  : null,
            ),
            const SizedBox(height: 16),
            const Text(
              'Nama',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            FormFieldText(
              hintText: 'Masukkan Nama',
              isEnabled: viewModel.isEditing,
              initialValue: name,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  viewModel.changeFamilyName(index: memberIndex, newName: newValue);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
