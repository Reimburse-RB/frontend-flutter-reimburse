import 'package:flutter/cupertino.dart';
import 'package:reimburse_rb/models/common/reimbursement_response.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';

class CardDetailSubmissionData {
  DetailCostOptionData? selectedDetailTitle;
  FamilyMemberData? selectedFamilyMember;
  DateTime? selectedDateTime;
  TextEditingController? otherDetailTitleController;
  TextEditingController? dateController;
  TextEditingController? costController;
  TextEditingController? descriptionController;

  CardDetailSubmissionData({
    this.selectedDetailTitle,
    this.selectedFamilyMember,
    this.selectedDateTime,
    this.dateController,
    this.costController,
    this.descriptionController,
  });
}
