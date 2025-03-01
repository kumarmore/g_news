class NewsModel {
  final String title;
  final String description;
  final String url;
  final String publishedAt;
  final String image;
  final String publisher;

  NewsModel({
    required this.title,
    required this.description,
    required this.url,
    required this.publishedAt,
    required this.image,
    required this.publisher,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      url: json['url'] ?? '',
      publishedAt: json['publishedAt'] ?? '',
      image: json['image'] != null && json['image'].isNotEmpty
          ? json['image']
          : 'https://via.placeholder.com/150?text=No+Image',
      publisher: json['source']['name'] ?? 'Unknown',
    );
  }
}