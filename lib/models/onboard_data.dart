class OnboardData {
  OnboardData({
    required this.image,
    required this.desc,
  });
  late final String image;
  late final String desc;

  OnboardData.fromJson(Map<String, dynamic> json) {
    image = json['image'] ?? '';
    desc = json['desc'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['image'] = image;
    data['desc'] = desc;
    return data;
  }
}
