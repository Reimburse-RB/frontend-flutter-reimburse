import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/auth_response.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/models/common/role_data.dart';
import 'package:reimburse_rb/provider/navigation_provider.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/utility/constant.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';

class SignUpViewModel extends ChangeNotifier {
  SignUpViewModel({
    required this.context,
  }) {
    getFcmToken();
  }

  final LocalStorage localStorage = LocalStorage('reimburse_rb');
  HttpService http = HttpService();
  late BuildContext context;

  String? fcmToken;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nikController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RoleData? _selectedRole;
  RoleData? get selectedRole => _selectedRole;

  List<RoleData> listRole = [
    RoleData(roleId: 1, roleText: 'Karyawan'),
    RoleData(roleId: 2, roleText: 'Admin'),
    RoleData(roleId: 3, roleText: 'HRD'),
  ];

  bool isObscured1 = true;
  bool isObscured2 = true;

  bool _isPasswordMatch = true;
  bool get isPasswordMatch => _isPasswordMatch;

  bool _isReadyToSubmit = false;
  bool get isReadyToSubmit => _isReadyToSubmit;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  void checkAllField() {
    _isReadyToSubmit = nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        selectedRole != null &&
        nikController.text.isNotEmpty &&
        isPasswordMatch;

    notifyListeners();
  }

  void changeRole(RoleData newSelectedRole) {
    _selectedRole = newSelectedRole;
    notifyListeners();
  }

  void checkIsPasswordMatch() {
    _isPasswordMatch = passwordController.text == confirmPasswordController.text;
    notifyListeners();
  }

  void changeIsObscuredText1() {
    isObscured1 = !isObscured1;
    notifyListeners();
  }

  void changeIsObscuredText2() {
    isObscured2 = !isObscured2;
    notifyListeners();
  }

  void navigateToLoginScreen({required BuildContext context}) {
    Navigator.of(context).pop();
  }

  Future getFcmToken() async {
    fcmToken = await FirebaseMessaging.instance.getToken();

    log('fcm token $fcmToken');
    return Future.value(true);
  }

  Future submitSignUp() async {
    log('=== register form test fcm token ${fcmToken}');
    log('=== register form test name ${nameController.text}');
    log('=== register form test email ${emailController.text}');
    log('=== register form test nik ${nikController.text}');
    log('=== register form test pass ${passwordController.text}');
    log('=== register form test confirm pass ${confirmPasswordController.text}');
    log('=== register form test selectedroleid ${selectedRole?.roleId ?? 0}');

    if (fcmToken == null) {
      Helper(context: context).showToast(
        message: Constant.defaultErrorMessage + " Harap coba lagi",
        isSuccess: false,
      );
      getFcmToken();
      return;
    }

    startLoading();
    notifyListeners();

    String endpoint = 'user/register';
    Map body = {
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
      'role': selectedRole?.roleId,
      'identity_number': nikController.text,
      'fcm_token': fcmToken,
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      SignUpResponse response = SignUpResponse.fromJson(res);
      if (response.success) {
        Helper(context: context).showToast(message: response.msg);

        bool isAdmin = response.data?.role == Constant.adminRoleId ||
            response.data?.role == Constant.hrdRoleId;

        localStorage.setItem('auth-token', response.data?.token);
        localStorage.setItem('role', response.data?.role);
        localStorage.setItem('is-admin-or-hrd', isAdmin);

        postEditProfile(response);

        context.read<UserProvider>().setIsAdmin(isAdmin);
        context.read<NavigationProvider>().navigateToMainMenuPage(context: context);
      } else {
        Helper(context: context).showToast(message: response.msg, isSuccess: false);
      }
    }).catchError((err) {
      log('===> error $endpoint $err');
      Helper(context: context).showToast(message: err.toString(), isSuccess: false);

      stopLoading();
      notifyListeners();
    });

    stopLoading();
    notifyListeners();
    return Future.value(true);
  }

  Future postEditProfile(SignUpResponse signUpResponse) async {
    String endpoint = 'user/edit-profile';
    Map body = {
      'identity_number': signUpResponse.data?.identity_number,
      'name': signUpResponse.data?.fullname,
      'email': signUpResponse.data?.email,
      'family_member_data': [
        {
          'id': null,
          'family_status_id': Constant.selfStatusId,
          'name': signUpResponse.data?.fullname,
        }
      ]
    };

    await http.post(endpoint: endpoint, body: body).then((res) {
      EditProfileResponse response = EditProfileResponse.fromJson(res);
      if (response.success) {
      } else {
        Helper(context: context).showToast(message: response.msg, isSuccess: false);
      }
    }).catchError((err) {
      log('===> error $endpoint $err');
      Helper(context: context).showToast(message: err.toString(), isSuccess: false);

      stopLoading();
      notifyListeners();
    });

    stopLoading();
    notifyListeners();
    return Future.value(true);
  }
}
