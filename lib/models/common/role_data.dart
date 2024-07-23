class RoleData {
  RoleData({
    required this.roleId,
    required this.roleText,
  });
  late final int roleId;
  late final String roleText;

  RoleData.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'] ?? 1;
    roleText = json['role_text'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['role_id'] = roleId;
    data['role_text'] = roleText;
    return data;
  }
}
