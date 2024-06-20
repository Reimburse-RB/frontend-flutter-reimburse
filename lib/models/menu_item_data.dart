class MenuItemData {
  MenuItemData({
    required this.assetImage,
    required this.title,
  });
  late final String assetImage;
  late final String title;

  MenuItemData.fromJson(Map<String, dynamic> json) {
    assetImage = json['asset_image'] ?? '';
    title = json['title'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['asset_image'] = assetImage;
    data['title'] = title;
    return data;
  }
}
