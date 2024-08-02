import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/models/employee/employee_summary_response.dart';

class UserProvider extends ChangeNotifier {
  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  void setIsAdmin(bool value) => _isAdmin = value;
  void clearIsAdmin() => _isAdmin = false;

  ProfileData? _profileData;
  ProfileData? get profileData => _profileData;
  void setProfileData(ProfileData? value) => _profileData = value;
  void clearProfileData() => _profileData = null;

  EmployeeSummaryData? _employeeSummaryData;
  EmployeeSummaryData? get employeeSummaryData => _employeeSummaryData;
  void setEmployeeSummaryData(EmployeeSummaryData? value) {
    _employeeSummaryData = value;
    notifyListeners();
  }

  void clearEmployeeSummaryData() {
    _employeeSummaryData = null;
    notifyListeners();
  }
}
