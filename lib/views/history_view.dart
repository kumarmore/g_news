import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/history_controller.dart';

class HistoryView extends StatelessWidget {
  final HistoryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('History')),
      ),
      body: Obx(
            () => controller.historyList.isEmpty
            ? Center(child: Text('No history yet'))
            : ListView.builder(
          itemCount: controller.historyList.length,
          itemBuilder: (context, index) {
            final history = controller.historyList[index];
            return Card(
              margin: EdgeInsets.all(8),
              child: ListTile(
                title: Text(history.title),
                subtitle: Text(history.timestamp),
                onTap: () {
                  // Optionally navigate to a detail view using history.url
                  Get.snackbar('Tapped', 'URL: ${history.url}');
                },
              ),
            );
          },
        ),
      ),
    );
  }
}