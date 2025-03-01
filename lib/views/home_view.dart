// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../models/news_model.dart';
// import '../controllers/news_controller.dart';
// import '../controllers/theme_controller.dart';
// import '../controllers/history_controller.dart';
// import 'news_detail_view.dart';
// import 'history_view.dart';
//
// class HomeView extends StatelessWidget {
//   final NewsController newsController = Get.put(NewsController());
//   final ThemeController themeController = Get.put(ThemeController());
//   final HistoryController historyController = Get.put(HistoryController());
//   final TextEditingController searchController = TextEditingController();
//
//   final List<String> categories = [
//     'general',
//     'sports',
//     'technology',
//     'politics',
//     'business',
//     'entertainment',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: categories.length, // Number of tabs
//       initialIndex: 0, // Start with 'general' category
//       child: Scaffold(
//         appBar: AppBar(
//           title: Center(child: Text('G News')),
//           actions: [
//             Obx(
//                   () => IconButton(
//                 icon: Icon(themeController.isDarkMode.value
//                     ? Icons.light_mode
//                     : Icons.dark_mode),
//                 onPressed: themeController.toggleTheme,
//               ),
//             ),
//           ],
//           bottom: PreferredSize(
//             preferredSize: Size.fromHeight(48.0), // Height of the TabBar
//             child: TabBar(
//               isScrollable: true, // Allows horizontal scrolling if tabs don’t fit
//               tabs: categories
//                   .map((category) => Tab(text: category.capitalizeFirst!))
//                   .toList(),
//               onTap: (index) {
//                 newsController.changeCategory(categories[index]);
//               },
//             ),
//           ),
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Get.isDarkMode ? Colors.purple[900] : Colors.purple,
//                 ),
//                 child: Text(
//                   'Categories',
//                   style: TextStyle(color: Colors.white, fontSize: 24),
//                 ),
//               ),
//               ...categories.map((category) => ListTile(
//                 title: Text(category.capitalizeFirst!),
//                 onTap: () {
//                   newsController.changeCategory(category);
//                   searchController.clear();
//                   Get.back();
//                 },
//               )),
//               ListTile(
//                 title: Text('History'),
//                 onTap: () {
//                   Get.back();
//                   Get.to(() => HistoryView());
//                 },
//               ),
//             ],
//           ),
//         ),
//         body: Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(16.0),
//               child: TextField(
//                 controller: searchController,
//                 decoration: InputDecoration(
//                   hintText: 'Search news...',
//                   border: OutlineInputBorder(),
//                   suffixIcon: IconButton(
//                     icon: Icon(Icons.search),
//                     onPressed: () {
//                       // newsController.searchNews(searchController.text);
//                     },
//                   ),
//                 ),
//                 onChanged: (value) {
//                   // newsController.searchNews(value); // Update search as user types
//                 },
//                 onSubmitted: (value) {
//                   // newsController.searchNews(value); // Trigger search on Enter
//                 },
//               ),
//             ),
//             Expanded(
//               child: TabBarView(
//                 children: categories.map((category) {
//                   return Obx(
//                         () => newsController.newsList.isEmpty
//                         ? Center(child: CircularProgressIndicator())
//                         : ListView.builder(
//                       itemCount: newsController.newsList.length,
//                       itemBuilder: (context, index) {
//                         final news = newsController.newsList[index];
//                         return Card(
//                           margin: EdgeInsets.all(12),
//                           color: Get.isDarkMode
//                               ? Colors.grey[850]!.withOpacity(0.8)
//                               : Colors.white.withOpacity(0.9),
//                           elevation: 4,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: InkWell(
//                             onTap: () {
//                               historyController.addToHistory(news);
//                               Get.to(() => NewsDetailView(news: news));
//                             },
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.vertical(
//                                       top: Radius.circular(12)),
//                                   child: Image.network(
//                                     news.image,
//                                     width: double.infinity,
//                                     height: 180,
//                                     fit: BoxFit.cover,
//                                     loadingBuilder:
//                                         (context, child, loadingProgress) {
//                                       if (loadingProgress == null) return child;
//                                       return Container(
//                                         width: double.infinity,
//                                         height: 180,
//                                         child: Center(
//                                             child: CircularProgressIndicator()),
//                                       );
//                                     },
//                                     errorBuilder: (context, error, stackTrace) {
//                                       return Container(
//                                         width: double.infinity,
//                                         height: 180,
//                                         color: Colors.grey[300],
//                                         child: Center(
//                                             child: Text('Image not available')),
//                                       );
//                                     },
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.all(12),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         news.title,
//                                         style: TextStyle(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold,
//                                           color: Get.isDarkMode
//                                               ? Colors.white
//                                               : Colors.black,
//                                         ),
//                                       ),
//                                       SizedBox(height: 8),
//                                       Text(
//                                         news.description,
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: Get.isDarkMode
//                                               ? Colors.white70
//                                               : Colors.black87,
//                                         ),
//                                         maxLines: 3,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                       SizedBox(height: 12),
//                                       Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Text(
//                                             news.publisher,
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Get.isDarkMode
//                                                   ? Colors.white60
//                                                   : Colors.grey[600],
//                                             ),
//                                           ),
//                                           Text(
//                                             news.publishedAt.split('T')[0],
//                                             style: TextStyle(
//                                               fontSize: 12,
//                                               color: Get.isDarkMode
//                                                   ? Colors.white60
//                                                   : Colors.grey[600],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }]

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/news_model.dart';
import '../controllers/news_controller.dart';
import '../controllers/theme_controller.dart';
import '../controllers/history_controller.dart';
import '../controllers/auth_controller.dart'; // New: For login/logout
import '../controllers/settings_controller.dart'; // New: For settings
import '../controllers/notification_controller.dart'; // New: For notifications
import 'news_detail_view.dart';
import 'history_view.dart';
import 'login_view.dart'; // New: Login screen
import 'settings_view.dart'; // New: Settings screen
import 'notifications_view.dart'; // New: Notifications screen

class HomeView extends StatelessWidget {
  final NewsController newsController = Get.put(NewsController());
  final ThemeController themeController = Get.put(ThemeController());
  final HistoryController historyController = Get.put(HistoryController());
  final AuthController authController = Get.put(AuthController()); // New
  final SettingsController settingsController = Get.put(SettingsController()); // New
  final NotificationController notificationController = Get.put(NotificationController()); // New
  final TextEditingController searchController = TextEditingController();

  final List<String> categories = [
    'general',
    'sports',
    'technology',
    'politics',
    'business',
    'entertainment',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('G News')),
          actions: [
            Obx(
                  () => IconButton(
                icon: Icon(themeController.isDarkMode.value
                    ? Icons.light_mode
                    : Icons.dark_mode),
                onPressed: themeController.toggleTheme,
              ),
            ),
            // Optional: Add notification badge/icon
            Obx(
                  () => IconButton(
                icon: Stack(
                  children: [
                    Icon(Icons.notifications),
                    if (notificationController.unreadNotifications.value > 0)
                      Positioned(
                        right: 0,
                        child: CircleAvatar(
                          radius: 8,
                          backgroundColor: Colors.red,
                          child: Text(
                            '${notificationController.unreadNotifications.value}',
                            style: TextStyle(fontSize: 10, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
                onPressed: () => Get.to(() => NotificationsView()),
              ),
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: TabBar(
              isScrollable: true,
              tabs: categories
                  .map((category) => Tab(text: category.capitalizeFirst!))
                  .toList(),
              onTap: (index) {
                newsController.changeCategory(categories[index]);
              },
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Get.isDarkMode ? Colors.purple[900] : Colors.purple,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'G News',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                    Obx(
                          () => Text(
                        authController.isLoggedIn.value
                            ? 'Welcome, ${authController.userName.value}'
                            : 'Guest',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              // Categories
              ...categories.map((category) => ListTile(
                title: Text(category.capitalizeFirst!),
                onTap: () {
                  newsController.changeCategory(category);
                  searchController.clear();
                  Get.back();
                },
              )),
              Divider(),
              // Login/Logout
              Obx(
                    () => ListTile(
                  title: Text(authController.isLoggedIn.value ? 'Logout' : 'Login'),
                  onTap: () {
                    if (authController.isLoggedIn.value) {
                      authController.logout();
                    } else {
                      Get.to(() => LoginView());
                    }
                    Get.back();
                  },
                ),
              ),
              // Settings
              ListTile(
                title: Text('Settings'),
                onTap: () {
                  Get.to(() => SettingsView());
                  Get.back();
                },
              ),
              // Notifications
              ListTile(
                title: Text('Notifications'),
                onTap: () {
                  Get.to(() => NotificationsView());
                  Get.back();
                },
              ),
              // History
              ListTile(
                title: Text('History'),
                onTap: () {
                  Get.back();
                  Get.to(() => HistoryView());
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search news...',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      final query = searchController.text?.trim() ?? '';
                      // newsController.searchNews(query);
                    },
                  ),
                ),
                onChanged: (value) {
                  final query = value?.trim() ?? '';
                  // newsController.searchNews(query);
                },
                onSubmitted: (value) {
                  final query = value?.trim() ?? '';
                  // newsController.searchNews(query);
                },
              ),
            ),
            Expanded(
              child: TabBarView(
                children: categories.map((category) {
                  return Obx(
                        () => newsController.newsList.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                      itemCount: newsController.newsList.length,
                      itemBuilder: (context, index) {
                        final news = newsController.newsList[index];
                        return Card(
                          margin: EdgeInsets.all(12),
                          color: Get.isDarkMode
                              ? Colors.grey[850]!.withOpacity(0.8)
                              : Colors.white.withOpacity(0.9),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: InkWell(
                            onTap: () {
                              historyController.addToHistory(news);
                              Get.to(() => NewsDetailView(news: news));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    news.image,
                                    width: double.infinity,
                                    height: 180,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        width: double.infinity,
                                        height: 180,
                                        child: Center(
                                            child: CircularProgressIndicator()),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        width: double.infinity,
                                        height: 180,
                                        color: Colors.grey[300],
                                        child: Center(
                                            child: Text('Image not available')),
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        news.title,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        news.description,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Get.isDarkMode
                                              ? Colors.white70
                                              : Colors.black87,
                                        ),
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 12),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            news.publisher,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Get.isDarkMode
                                                  ? Colors.white60
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                          Text(
                                            news.publishedAt.split('T')[0],
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: Get.isDarkMode
                                                  ? Colors.white60
                                                  : Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}