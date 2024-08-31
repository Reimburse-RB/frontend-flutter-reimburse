import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/widgets/common/button_general.dart';
import 'package:reimburse_rb/widgets/common/form_date_picker.dart';

class ModalDateRange {
  final BuildContext context;
  final String title;
  final Function() onTapContinue;

  ModalDateRange({
    required this.context,
    required this.title,
    required this.onTapContinue,
  });

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  DateTime firstDate = DateTime(2000);
  DateTime lastDate = DateTime.now();

  void show() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 32),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight:
                  MediaQuery.of(context).size.height * 0.8, // max height 80% of screen height
            ),
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
                FormDatePicker(
                  hintText: 'Tanggal Awal',
                  controller: startDateController,
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
                const SizedBox(height: 20),
                ButtonGeneral(onTap: () {}, text: 'Cetak'),
                const SizedBox(height: 16),
              ],
            ),
          ),
        );
      },
    );
  }
}
