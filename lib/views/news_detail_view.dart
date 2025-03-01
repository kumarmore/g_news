import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/news_model.dart';

class NewsDetailView extends StatelessWidget {
  final NewsModel news;

  NewsDetailView({required this.news});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      Get.snackbar('Error', 'Could not launch $url');
    }
  }

  // Helper function to format date and time
  String _formatDateTime(String publishedAt) {
    try {
      final dateTime = DateTime.parse(publishedAt);
      final date = '${dateTime.day}/${dateTime.month}/${dateTime.year}';
      final time = '${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
      return '$date $time';
    } catch (e) {
      print('Error parsing date: $e');
      return publishedAt; // Fallback to original if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Detail'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {
              Share.share('${news.title}\n${news.url}');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (news.image.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  news.image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      width: double.infinity,
                      height: 200,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    print('Detail image failed to load: ${news.image} - $error');
                    return Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[300],
                      child: Center(child: Text('Image not available')),
                    );
                  },
                ),
              ),
            SizedBox(height: 16),
            Text(
              news.title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Get.isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              news.description,
              style: TextStyle(
                fontSize: 16,
                color: Get.isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _launchUrl(news.url), // Open full article when publisher is tapped
                    child: Text(
                      'Source: ${news.publisher}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Get.isDarkMode ? Colors.white60 : Colors.grey,
                        decoration: TextDecoration.underline, // Optional: Makes it look clickable
                      ),
                      overflow: TextOverflow.ellipsis, // Prevents text overflow
                    ),
                  ),
                ),
                SizedBox(width: 8), // Add spacing between publisher and date
                Expanded(
                  child: Text(
                    _formatDateTime(news.publishedAt),
                    style: TextStyle(
                      fontSize: 14,
                      color: Get.isDarkMode ? Colors.white60 : Colors.grey,
                    ),
                    textAlign: TextAlign.end, // Aligns text to the right
                    overflow: TextOverflow.ellipsis, // Prevents text overflow
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _launchUrl(news.url),
              child: Text('Read More'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}