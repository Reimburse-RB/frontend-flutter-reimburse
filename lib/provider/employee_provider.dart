import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/employee/employee_summary_response.dart';
import 'package:intl/intl.dart';

class EmployeeProvider extends ChangeNotifier {
  EmployeeSummaryData? _employeeSummaryData;
  EmployeeSummaryData? get employeeSummaryData => _employeeSummaryData;
  void setEmployeeSummaryData(EmployeeSummaryData? value) => _employeeSummaryData = value;
  void clearEmployeeSummaryData() => _employeeSummaryData = null;

  String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ');
    return formatCurrency.format(amount);
  }
}
