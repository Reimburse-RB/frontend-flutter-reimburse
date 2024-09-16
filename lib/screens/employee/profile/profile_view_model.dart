import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:provider/provider.dart';
import 'package:reimburse_rb/models/common/profile_response.dart';
import 'package:reimburse_rb/provider/user_provider.dart';
import 'package:reimburse_rb/screens/common/auth/change_password/change_password_view.dart';
import 'package:reimburse_rb/screens/common/auth/signin/signin_view.dart';
import 'package:reimburse_rb/utility/helper.dart';
import 'package:reimburse_rb/utility/http_service.dart';
import 'package:reimburse_rb/utility/image_picker_handler.dart';

class ProfileViewModel extends ChangeNotifier with ImagePickerListener {
  ProfileViewModel({
    required this.context,
    this.isProfileDetail = false,
  }) {
    final provider = context.read<UserProvider>();
    _isAdmin = provider.isAdmin;

    getProfile();
  }
  HttpService http = HttpService();
  final LocalStorage localStorage = LocalStorage('reimburse_rb');

  late ImagePickerHandler imagePicker;

  BuildContext context;
  bool isProfileDetail = false;

  bool _isEditing = false;
  bool get isEditing => _isEditing;

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  ProfileData? _profile;
  ProfileData? get profile => _profile;

  File? _newProfileImageFile;
  File? get newProfileImageFile => _newProfileImageFile;

  String? _newProfileImageBase64;
  String? get newProfileImageBase64 => _newProfileImageBase64;

  // loading page
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void startLoading() => _isLoading = true;
  void stopLoading() => _isLoading = false;

  // edit profile
  Map _bodyEditProfile = {};
  Map get bodyEditProfile => _bodyEditProfile;
  List _listEditFamilyMemberData = [];
  List get listEditFamilyMemberData => _listEditFamilyMemberData;

  // late ProfileData _backupOriginalProfile;
  // ProfileData get backupOriginalProfile => _backupOriginalProfile;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nikController = TextEditingController();

  // List<FamilyMemberOption> listFamilyStatusOption = [
  //   FamilyMemberOption(family_status_id: 1, family_status_text: "Diri Sendiri"),
  //   FamilyMemberOption(family_status_id: 2, family_status_text: "Suami"),
  //   FamilyMemberOption(family_status_id: 3, family_status_text: "Istri"),
  //   FamilyMemberOption(family_status_id: 4, family_status_text: "Anak"),
  // ];

  List<Map<String, dynamic>> listFamilyStatusOptionMap = [
    {'id': 1, 'text': 'Diri Sendiri'},
    {'id': 2, 'text': 'Suami'},
    {'id': 3, 'text': 'Istri'},
    {'id': 4, 'text': 'Anak'},
  ];

  Future getProfile() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/get-profile';

    await http.post(endpoint: endpoint).then((res) {
      ProfileResponse response = ProfileResponse.fromJson(res);
      if (response.success) {
        final provider = context.read<UserProvider>();
        provider.setProfileData(response.data);
        provider.setIsAccountVerified(response.data?.is_account_verified ?? false);
        log('isAccountVerified ${provider.isAccountVerified}');

        _profile = response.data;

        if (isProfileDetail) {
          setProfileFormData();
          _listEditFamilyMemberData = res['data']['family_member_data'];
        }

        notifyListeners();
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

  Future postEditProfile() async {
    startLoading();
    notifyListeners();

    String endpoint = 'user/edit-profile';
    Map body = bodyEditProfile;

    await http.post(endpoint: endpoint, body: body).then((res) {
      EditProfileResponse response = EditProfileResponse.fromJson(res);
      if (response.success) {
        _isEditing = false;
        _newProfileImageFile = null;
        _newProfileImageBase64 = null;
        Helper(context: context).showToast(message: response.msg, isSuccess: true);
        getProfile();
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

  Future setProfileFormData() {
    nameController.text = profile?.name ?? '';
    emailController.text = profile?.email ?? '';
    nikController.text = profile?.nik ?? '';
    notifyListeners();

    return Future.value(true);
  }

  Future startEdit() {
    _isEditing = true;
    setInitialBodyEditProfile();

    notifyListeners();

    return Future.value(true);
  }

  Future cancelEdit() {
    _isEditing = false;
    _newProfileImageFile = null;
    _newProfileImageBase64 = null;
    getProfile();

    notifyListeners();

    return Future.value(true);
  }

  Future setInitialBodyEditProfile() {
    _bodyEditProfile['identity_number'] = profile?.nik;
    _bodyEditProfile['name'] = profile?.name;
    _bodyEditProfile['email'] = profile?.email;
    _bodyEditProfile['family_member_data'] = listEditFamilyMemberData;

    log('===> initial body edit profile ${bodyEditProfile}');
    notifyListeners();

    return Future.value(true);
  }

  Future saveEdit() {
    _bodyEditProfile['name'] = nameController.text;
    _bodyEditProfile['identity_number'] = nikController.text;
    _bodyEditProfile['email'] = emailController.text;
    _bodyEditProfile['image'] = newProfileImageBase64;
    _bodyEditProfile['family_member_data'] = listEditFamilyMemberData;

    log('===> save body edit profile ${bodyEditProfile}');

    postEditProfile();

    notifyListeners();

    return Future.value(true);
  }

  onTapAddImage({required AnimationController animationController}) {
    imagePicker = ImagePickerHandler(this, animationController);
    imagePicker.init(context);
    imagePicker.showDialog(context);
  }

  addImage({required File imageFile}) {
    String imageBase64 = base64Encode(imageFile.readAsBytesSync());

    _newProfileImageFile = imageFile;
    _newProfileImageBase64 = imageBase64;

    notifyListeners();
  }

  Future addFamilyMember() {
    _profile?.family_member_data.add(
      FamilyMemberData(
        family_status_id: 4,
        family_status_text: 'Anak',
        name: 'Member Baru',
      ),
    );
    _listEditFamilyMemberData.add(
      {
        'id': null,
        'family_status_id': '4',
        'family_status_text': 'Anak',
        'name': 'Member Baru',
      },
    );
    notifyListeners();

    return Future.value(true);
  }

  Future removeFamilyMember({required int index}) {
    _profile?.family_member_data.removeAt(index);
    _listEditFamilyMemberData.removeAt(index);
    notifyListeners();

    return Future.value(true);
  }

  Future changeFamilyName({
    required int index,
    required String newName,
  }) {
    listEditFamilyMemberData[index]['name'] = newName;
    notifyListeners();

    return Future.value(true);
  }

  Future changeFamilyStatus({
    required int index,
    required Map<String, dynamic> newStatus,
  }) {
    log('===> change body family status profile $index ${newStatus}');

    listEditFamilyMemberData[index]['family_status_id'] = newStatus['id'].toString();
    notifyListeners();

    return Future.value(true);
  }

  void signOut() {
    localStorage.clear();
    context.read<UserProvider>().clearAllData();

    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(builder: (context) => const SignInScreen()),
      (Route<dynamic> route) => false, // Hapus semua rute sebelumnya
    );
  }

  @override
  void userImage(File image) {
    // String base64Image = base64Encode(image.readAsBytesSync());
    String fileName = image.path.split("/").last;
    // Uint8List byestsImg = const Base64Decoder().convert(base64Image);

    addImage(imageFile: image);

    log('===> imagepicker fileName $fileName');
  }
}
