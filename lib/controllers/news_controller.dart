import 'package:get/get.dart';
import '../models/news_model.dart';
import '../services/news_service.dart';

class NewsController extends GetxController {
  final NewsService _newsService = NewsService();
  RxList<NewsModel> newsList = <NewsModel>[].obs;
  RxString selectedCategory = 'general'.obs;

  @override
  void onInit() {
    fetchNews();
    super.onInit();
  }

  void fetchNews() async {
    try {
      newsList.value = await _newsService.fetchNews(selectedCategory.value);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load news: $e');
    }
  }

  void changeCategory(String category) {
    selectedCategory.value = category;
    fetchNews();
  }
}