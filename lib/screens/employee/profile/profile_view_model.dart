import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reimburse_rb/models/employee/profile_data.dart';
import 'package:reimburse_rb/screens/common/auth/forgot_password/forgot_password_view.dart';
import 'package:reimburse_rb/screens/employee/profile/profile_detail/profile_detail_view.dart';

class ProfileViewModel extends ChangeNotifier {
  ProfileViewModel({
    required this.context,
    this.isProfileDetail = false,
  }) {
    getProfile();
    if (isProfileDetail) {
      setProfileFormData();
    }
  }
  BuildContext context;
  bool isProfileDetail = false;

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nikController = TextEditingController();

  List<FamilyMemberOption> listFamilyStatusOption = [
    FamilyMemberOption(familyStatusId: 1, familyStatusText: 'Diri Sendiri'),
    FamilyMemberOption(familyStatusId: 2, familyStatusText: 'Suami'),
    FamilyMemberOption(familyStatusId: 3, familyStatusText: 'Istri'),
    FamilyMemberOption(familyStatusId: 4, familyStatusText: 'Anak'),
  ];

  // List listFamilyStatusOption = [
  //   {
  //     'family_status_id': 1,
  //     'family_status_text': 'Diri sendiri',
  //   },
  //   {
  //     'family_status_id': 2,
  //     'family_status_text': 'Suami',
  //   },
  //   {
  //     'family_status_id': 3,
  //     'family_status_text': 'Istri',
  //   },
  //   {
  //     'family_status_id': 4,
  //     'family_status_text': 'Anak',
  //   },
  // ];

  Map<String, dynamic> tempProfile = {
    'name': 'Yudha Haryoputranto',
    'email': 'yudhah52@gmail.com',
    'nik': '2010511068',
    'img_url':
        'https://media.licdn.com/dms/image/C5603AQFOfZiG507GCg/profile-displayphoto-shrink_800_800/0/1644315854486?e=1725494400&v=beta&t=AEKapy2te-iNY6J4Qz4NpHgllXpQdQVWV26YBBOAaWM',
    'role_id': 1,
    'role_text': 'Karyawan',
    'family_member_data': [
      {'family_status_id': 1, 'family_status_text': 'Diri Sendiri', 'name': 'Yudha Haryoputranto'},
      {
        'family_status_id': 3,
        'family_status_text': 'Istri',
        'name': 'Freya Jayawardana',
      },
      {
        'family_status_id': 4,
        'family_status_text': 'Anak',
        'name': 'Yhezra',
      },
    ]
  };

  bool _isAdmin = false;
  bool get isAdmin => _isAdmin;

  late ProfileData _profile;
  ProfileData get profile => _profile;

  Future getProfile() {
    _profile = ProfileData.fromJson(tempProfile);
    _isAdmin = _profile.roleId != 1;

    notifyListeners();

    return Future.value(true);
  }

  Future setProfileFormData() {
    nameController.text = profile.name;
    emailController.text = profile.email;
    nikController.text = profile.nik;
    notifyListeners();

    return Future.value(true);
  }

  void navigateToProfileDetail() {
    Navigator.push(context, CupertinoPageRoute(builder: (context) => const ProfileDetailSceen()));
  }

  void navigateToForgotPasswordScreen() {
    Navigator.of(context).push(CupertinoPageRoute(
      builder: (context) => const ForgotPasswordScreen(),
    ));
  }
}
