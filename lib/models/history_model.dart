class HistoryModel {
  final int? id;
  final String title;
  final String url;
  final String timestamp;

  HistoryModel({
    this.id,
    required this.title,
    required this.url,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
      'timestamp': timestamp,
    };
  }

  factory HistoryModel.fromMap(Map<String, dynamic> map) {
    return HistoryModel(
      id: map['id'],
      title: map['title'],
      url: map['url'],
      timestamp: map['timestamp'],
    );
  }
}