class ProfileData {
  ProfileData({
    required this.name,
    required this.email,
    required this.nik,
    required this.imgUrl,
    required this.roleId,
    required this.roleText,
    required this.listFamilyMember,
  });

  late final String name;
  late final String email;
  late final String nik;
  late final String imgUrl;
  late final int roleId;
  late final String roleText;
  late final List<FamilyMemberData> listFamilyMember;

  ProfileData.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? '';
    email = json['email'] ?? '';
    nik = json['nik'] ?? '';
    imgUrl = json['img_url'] ?? '';
    roleId = json['role_id'] ?? 0;
    roleText = json['role_text'] ?? '';
    listFamilyMember = (json['family_member_data'] as List<dynamic>)
        .map((e) => FamilyMemberData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['nik'] = nik;
    data['img_url'] = imgUrl;
    data['role_id'] = roleId;
    data['role_text'] = roleText;
    data['family_member_data'] = listFamilyMember.map((e) => e.toJson()).toList();
    return data;
  }
}

class FamilyMemberData {
  FamilyMemberData({
    required this.familyStatusId,
    required this.familyStatusText,
    required this.name,
  });

  late final int familyStatusId;
  late final String familyStatusText;
  late final String name;

  FamilyMemberData.fromJson(Map<String, dynamic> json) {
    familyStatusId = json['family_status_id'] ?? 0;
    familyStatusText = json['family_status_text'] ?? '';
    name = json['name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['family_status_id'] = familyStatusId;
    data['family_status_text'] = familyStatusText;
    data['name'] = name;
    return data;
  }
}

// class FamilyMemberOption {
//   FamilyMemberOption({
//     required this.familyStatusId,
//     required this.familyStatusText,
//   });

//   late final int familyStatusId;
//   late final String familyStatusText;
// }

class FamilyMemberOption {
  FamilyMemberOption({
    required this.familyStatusId,
    required this.familyStatusText,
  });

  final int familyStatusId;
  final String familyStatusText;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FamilyMemberOption &&
          runtimeType == other.runtimeType &&
          familyStatusId == other.familyStatusId &&
          familyStatusText == other.familyStatusText;

  @override
  int get hashCode => familyStatusId.hashCode ^ familyStatusText.hashCode;
}
