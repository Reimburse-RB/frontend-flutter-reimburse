import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/form_dropdown_detail_cost.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';

class CardDetailCost extends StatelessWidget {
  final SubmissionFormViewModel viewModel;
  final int detailCostIndex;
  final Map<String, dynamic>? status;
  final List<Map<String, dynamic>> listStatusOption;

  const CardDetailCost({
    Key? key,
    required this.viewModel,
    required this.detailCostIndex,
    this.status,
    required this.listStatusOption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userProvider = context.read<UserProvider>();
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Rincian ${detailCostIndex + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                if (viewModel.listBodyDetailCost.length > 1)
                  InkWell(
                    onTap: () {
                      viewModel.removeDetailCost(index: detailCostIndex);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userProvider.selectedReimbursementCategory?.categoryReimbursementId == 1
                      ? 'Rincian Perawatan'
                      : 'Rincian Perjalanan',
                  style: const TextStyle(
                    fontWeight: Constant.boldText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                FormDropdownDetailCost(
                  hintText: userProvider.selectedReimbursementCategory?.categoryReimbursementId == 1
                      ? 'Pilih Rincian Perawatan'
                      : 'Pilih Rincian Perjalanan',
                  items: viewModel.listDetailOption ?? [],
                  onChanged: (newValue) {},
                ),
                const SizedBox(height: 16),
                const Text(
                  'Keterangan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                FormFieldText(
                  hintText: 'Masukkan biaya',
                  isCost: true,
                  keyboardType: TextInputType.number,
                  onChanged: (String? newValue) {},
                ),
                const SizedBox(height: 16),
                const Text(
                  'Keterangan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                FormFieldText(
                  controllerName: TextEditingController(),
                  hintText: 'Masukkan keterangan lain',
                  minLines: 5,
                  maxLines: 5,
                  onChanged: (String? newValue) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
