import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/employee/profile_data.dart';
import 'package:reimburse_rb/screens/employee/profile/profile_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardFamilyMember extends StatelessWidget {
  final ProfileViewModel viewModel;
  final int memberIndex;
  final FamilyMemberOption? status;
  final String name;
  final List<FamilyMemberOption> listStatusOption;
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
            DropdownButtonFormField<FamilyMemberOption>(
              value: status,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Pilih Status Keluarga',
              ),
              focusColor: Constant.greenDark,
              dropdownColor: Constant.greenMoreVeryLight,
              icon: const Icon(
                Icons.arrow_drop_down_rounded,
                color: Constant.green,
              ),
              items: listStatusOption.map((FamilyMemberOption option) {
                return DropdownMenuItem<FamilyMemberOption>(
                  value: option,
                  child: Text(option.familyStatusText),
                );
              }).toList(),
              onChanged: (viewModel.isEditing)
                  ? (newValue) {
                      if (newValue != null) {
                        viewModel.changeFamilyStatus(index: memberIndex, newStatus: newValue);
                      }
                      log('current status $newValue ${newValue?.familyStatusId}${newValue?.familyStatusText}');
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
            TextFormField(
              initialValue: name,
              enabled: viewModel.isEditing,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusColor: Constant.greenDark,
                hintText: 'Masukkan Nama',
              ),
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
