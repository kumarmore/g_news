import 'package:get/get.dart';
import '../models/history_model.dart';
import '../models/news_model.dart';
import '../services/database_service.dart';

class HistoryController extends GetxController {
  final DatabaseService _dbService = DatabaseService();
  RxList<HistoryModel> historyList = <HistoryModel>[].obs;

  @override
  void onInit() {
    fetchHistory();
    super.onInit();
  }

  void addToHistory(NewsModel news) async {
    final history = HistoryModel(
      title: news.title,
      url: news.url,
      timestamp: DateTime.now().toIso8601String(),
    );
    await _dbService.insertHistory(history);
    fetchHistory();
  }

  void fetchHistory() async {
    historyList.value = await _dbService.getHistory();
  }
}