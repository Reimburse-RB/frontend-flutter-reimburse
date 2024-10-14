import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/employee/submission/submission_form/submission_form_view_model.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/widgets/common/form_date_picker.dart';
import 'package:reimburse_rb/widgets/common/form_dropdown_detail_cost.dart';
import 'package:reimburse_rb/widgets/common/form_dropdown_family_member.dart';
import 'package:reimburse_rb/widgets/common/form_field_text.dart';
import 'package:reimburse_rb/widgets/common/form_small_note.dart';

class CardFormDetailCost extends StatelessWidget {
  final SubmissionFormViewModel viewModel;
  final int detailCostIndex;
  final Map<String, dynamic>? detailTitleValue;

  const CardFormDetailCost({
    Key? key,
    required this.viewModel,
    required this.detailCostIndex,
    this.detailTitleValue,
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
                FormSmallNote(
                  prefixIcon: const Icon(
                    Icons.warning_amber_rounded,
                    color: Constant.waitingStatusColor,
                  ),
                  note: userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                          Constant.healthCategoryReimbursementId
                      ? Constant.infoFormDetailCostHealth
                      : Constant.infoFormDetailCostTransport,
                  noteTextStyle: TextStyle(
                    color: Constant.waitingStatusColor,
                    fontWeight: Constant.regularNoteStyle.fontWeight,
                    fontSize: Constant.regularNoteStyle.fontSize,
                    fontStyle: Constant.regularNoteStyle.fontStyle,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                          Constant.healthCategoryReimbursementId
                      ? 'Rincian Perawatan'
                      : 'Rincian Perjalanan',
                  style: const TextStyle(
                    fontWeight: Constant.boldText,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                FormDropdownDetailCost(
                  value: viewModel.listControllerDetailCost[detailCostIndex].selectedDetailTitle,
                  hintText: userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                          Constant.healthCategoryReimbursementId
                      ? 'Pilih Rincian Perawatan'
                      : 'Pilih Rincian Perjalanan',
                  items: viewModel.listDetailOption ?? [],
                  onChanged: (newValue) {
                    if (newValue != null) {
                      viewModel.onChangeDetailTitle(index: detailCostIndex, newValue: newValue);
                    }
                  },
                ),
                if (viewModel.listControllerDetailCost[detailCostIndex].selectedDetailTitle
                        ?.detail_title_id ==
                    1) ...[
                  const SizedBox(height: 8),
                  FormFieldText(
                    controllerName: viewModel
                        .listControllerDetailCost[detailCostIndex].otherDetailTitleController,
                    hintText: userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                            Constant.healthCategoryReimbursementId
                        ? 'Masukkan Rincian Perawatan Lain'
                        : 'Masukkan Rincian Perjalanan Lain',
                    onChanged: (String? newValue) {
                      if (newValue != null) {
                        viewModel.onChangeOtherDetailTitle(
                            index: detailCostIndex, newValue: newValue);
                      }
                    },
                  ),
                ],
                const SizedBox(height: 16),
                if (userProvider.selectedReimbursementCategory?.categoryReimbursementId ==
                    Constant.healthCategoryReimbursementId) ...[
                  const Text(
                    'Diperuntukkan Untuk',
                    style: TextStyle(
                      fontWeight: Constant.boldText,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  FormDropdownFamilyMember(
                    value: viewModel.listControllerDetailCost[detailCostIndex].selectedFamilyMember,
                    hintText: 'Pilih Anggota Keluarga',
                    items: viewModel.profile?.family_member_data ?? [],
                    onChanged: (newValue) {
                      if (newValue != null) {
                        viewModel.onChangeFamilyMember(index: detailCostIndex, newValue: newValue);
                      }
                    },
                    note: Constant.noteFormFamilyMember,
                    prefixIconNote: Icon(
                      Icons.info_rounded,
                      color: Constant.waitingStatusColor,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
                const Text(
                  'Tanggal Kuitansi',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                FormDatePicker(
                  hintText: 'Tanggal kuitansi',
                  controller: viewModel.listControllerDetailCost[detailCostIndex].dateController,
                  onTap: () {
                    viewModel.onChangeDate(index: detailCostIndex);
                  },
                  note: Constant.noteFormDateDetailTitle,
                  prefixIconNote: Icon(
                    Icons.info_rounded,
                    color: Constant.waitingStatusColor,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Biaya',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                FormFieldText(
                  controllerName:
                      viewModel.listControllerDetailCost[detailCostIndex].costController,
                  hintText: 'Masukkan biaya',
                  isCost: true,
                  keyboardType: TextInputType.number,
                  onChanged: (String? newValue) {},
                  onEditingComplete: () {
                    viewModel.onEditingCompleteCost(index: detailCostIndex);
                  },
                  onFocusLost: () {
                    viewModel.onEditingCompleteCost(index: detailCostIndex);
                  },
                ),
                const SizedBox(height: 16),
                const Text(
                  'Keterangan (Opsional)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                FormFieldText(
                  controllerName:
                      viewModel.listControllerDetailCost[detailCostIndex].descriptionController,
                  hintText: 'Masukkan keterangan lain',
                  minLines: 5,
                  maxLines: 5,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      viewModel.onChangeDescription(index: detailCostIndex, newValue: newValue);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
