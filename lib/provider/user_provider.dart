import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/models/employee/employee_summary_response.dart';

class UserProvider extends ChangeNotifier {
  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;
  void setIsAdmin(bool value) => _isAdmin = value;
  void clearIsAdmin() => _isAdmin = false;

  List<ReimbursementCategoryData> listReimbursementCategory = [
    ReimbursementCategoryData(
      categoryReimbursementId: 1,
      categoryReimbursementText: 'Kesehatan',
    ),
    ReimbursementCategoryData(
      categoryReimbursementId: 2,
      categoryReimbursementText: 'Transportasi',
    ),
  ];

  ProfileData? _profileData;
  ProfileData? get profileData => _profileData;
  void setProfileData(ProfileData? value) {
    _profileData = value;
    notifyListeners();
  }

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

  ReimbursementCategoryData? _selectedReimbursementCategory;
  ReimbursementCategoryData? get selectedReimbursementCategory => _selectedReimbursementCategory;
  void setSelectedReimbursementCategoryId(ReimbursementCategoryData value) =>
      _selectedReimbursementCategory = value;
  void clearSelectedReimbursementCategoryId() => _selectedReimbursementCategory = null;

  int _selectedSubmissionTabIndex = 0;
  int get selectedSubmissionTabIndex => _selectedSubmissionTabIndex;
  void setSelectedSubmissionTabIndex(int value) => _selectedSubmissionTabIndex = value;
  void clearSelectedSubmissionTabIndex() => _selectedSubmissionTabIndex = 0;

  int? _selectedDetailReimbursementId;
  int? get selectedDetailReimbursementId => _selectedDetailReimbursementId;
  void setSelectedDetailReimbursementId(int value) => _selectedDetailReimbursementId = value;
  void clearSelectedDetailReimbursementId() => _selectedDetailReimbursementId = null;
}
