import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/form_check_map.dart';
import 'package:reimburse_rb/widgets/common/form_date_picker.dart';
import 'package:reimburse_rb/widgets/common/form_dialog_string.dart';

class ModalRecapitulationPrint {
  final BuildContext context;
  final String title;
  final Function(List, String, String, String) onTapContinue;

  ModalRecapitulationPrint({
    required this.context,
    required this.title,
    required this.onTapContinue,
  });

  List<Map<String, dynamic>> listOptionFieldCheckCategory = [
    {"id_option": 1, "text_option": "Kategori Kesehatan"},
    {"id_option": 2, "text_option": "Transportasi"},
  ];
  List<String> listOptionFieldDocumentType = ['PDF', 'Excel'];

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  List selectedReimbursementCategoryIds = [];
  String selectedDocumentType = 'PDF';

  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime.now();

  void show() {
    selectedReimbursementCategoryIds = listOptionFieldCheckCategory.map((item) {
      return item['id_option'];
    }).toList();
    selectedDocumentType = listOptionFieldDocumentType[0];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          expand: false,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormCheckMap(
                      placeholder: "Kategori",
                      options: listOptionFieldCheckCategory,
                      onChanged: (selectedOptionsIds) {
                        print("Selected options: $selectedOptionsIds");
                        selectedReimbursementCategoryIds = List.from(selectedOptionsIds);
                      },
                    ),
                    const SizedBox(height: 16),
                    FormDialogString(
                      placeholder: "Tipe Dokumen",
                      options: listOptionFieldDocumentType, // Menggunakan List<String>
                      onChanged: (selectedOption) {
                        print("Selected options: $selectedOption");

                        selectedDocumentType = selectedOption;
                      },
                    ),
                    const SizedBox(height: 16),
                    FormDatePicker(
                      hintText: 'Tanggal Awal',
                      controller: startDateController,
                      placeholder: "Pilih Periode",
                      onTap: () async {
                        final DateTime? pickedDate = await Helper(context: context).onChangeDate(
                          context: context,
                          firstDate: firstDate,
                          lastDate: lastDate,
                          initialDate: lastDate,
                        );
                        if (pickedDate != null) {
                          startDateController.text = DateFormat('yyyy/MM/dd').format(pickedDate);
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    FormDatePicker(
                      hintText: 'Tanggal Akhir',
                      controller: endDateController,
                      onTap: () async {
                        final DateTime? pickedDate = await Helper(context: context).onChangeDate(
                          context: context,
                          firstDate: firstDate,
                          lastDate: lastDate,
                          initialDate: lastDate,
                        );
                        if (pickedDate != null) {
                          endDateController.text = DateFormat('yyyy/MM/dd').format(pickedDate);
                        }
                      },
                    ),
                    const SizedBox(height: 32),
                    ButtonGeneral(
                      onTap: () {
                        log('${startDateController.text} ${endDateController.text} ${selectedReimbursementCategoryIds} ${selectedDocumentType}');
                        if (startDateController.text.isEmpty ||
                            endDateController.text.isEmpty ||
                            selectedReimbursementCategoryIds.isEmpty ||
                            selectedDocumentType.isEmpty) {
                          Helper(context: context).showToast(
                              message: Constant.warningFormIncompleteGeneral, isSuccess: false);
                          return;
                        }

                        onTapContinue(
                          selectedReimbursementCategoryIds,
                          selectedDocumentType,
                          startDateController.text,
                          endDateController.text,
                        );
                      },
                      text: 'Cetak',
                    ),
                    const SizedBox(height: 64),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
