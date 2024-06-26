class TermConditionData {
  TermConditionData({
    required this.title,
    required this.listTnc,
  });

  late final String title;
  late final List<String> listTnc;

  TermConditionData.fromJson(Map json) {
    title = json['title'] ?? '';
    listTnc = json['list_tnc'] ?? [];
  }
}
