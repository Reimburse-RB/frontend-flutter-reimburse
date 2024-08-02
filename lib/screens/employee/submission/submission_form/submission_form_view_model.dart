import 'package:flutter/material.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class SubmissionFormViewModel extends ChangeNotifier {
  SubmissionFormViewModel() {}

  HttpService http = HttpService();

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;
}
