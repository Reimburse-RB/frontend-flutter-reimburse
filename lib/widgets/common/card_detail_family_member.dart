import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/detail_text.dart';

class CardDetailFamilyMember extends StatelessWidget {
  final FamilyMemberData itemFamilyMemberData;
  final int index;

  const CardDetailFamilyMember({
    Key? key,
    required this.itemFamilyMemberData,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            decoration: const BoxDecoration(
              color: Constant.greenDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            width: MediaQuery.of(context).size.width,
            alignment: Alignment.center,
            child: Text(
              'Anggota Keluarga ${index + 1}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailText(
                  margin: EdgeInsets.zero,
                  title: 'Status',
                  textValue: itemFamilyMemberData.family_status_text,
                ),
                DetailText(
                  margin: EdgeInsets.only(top: 16),
                  title: 'Nama',
                  textValue: itemFamilyMemberData.name,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
