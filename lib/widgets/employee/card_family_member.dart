import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/employee/profile_data.dart';
import 'package:reimburse_rb/utility/constant.dart';

class CardFamilyMember extends StatelessWidget {
  final int memberIndex;
  final String status;
  final String name;
  final List<FamilyMemberOption> listStatusOption;
  final bool isActiveDeleteButton;
  final VoidCallback onDelete;

  const CardFamilyMember({
    Key? key,
    required this.memberIndex,
    required this.status,
    required this.name,
    required this.listStatusOption,
    this.isActiveDeleteButton = true,
    required this.onDelete,
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
                  'Anggota Keluarga $memberIndex',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.green[900],
                  ),
                ),
                if (isActiveDeleteButton)
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.green[900]),
                    onPressed: onDelete,
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
            DropdownButtonFormField<String>(
              value: status,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              focusColor: Constant.greenDark,
              dropdownColor: Constant.greenMoreVeryLight,
              icon: const Icon(
                Icons.arrow_drop_down_rounded,
                color: Constant.green,
              ),
              borderRadius: BorderRadius.circular(12),
              items: listStatusOption.map((FamilyMemberOption option) {
                return DropdownMenuItem<String>(
                  value: option.familyStatusText,
                  child: Text(option.familyStatusText),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Handle status change
              },
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
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (String? newValue) {
                // Handle name change
              },
            ),
          ],
        ),
      ),
    );
  }
}
