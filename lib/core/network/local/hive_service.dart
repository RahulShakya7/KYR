import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../../config/constants/hive_table_constant.dart';
import '../../../features/auth/data/model/user_hive_model.dart';
import '../../../features/news/data/model/news_hive_model.dart';

final hiveServiceProvider = Provider(
  (ref) => HiveService(),
);

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();

    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);

    // Register Adapters
    // Hive.registerAdapter(UserHiveModelAdapter());
    // Hive.registerAdapter(NewsHiveModelAdapter());
  }

  // ======================== User Queries ========================
  Future<void> addUser(UserHiveModel user) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    await box.put(user.userid, user);
  }

  Future<List<UserHiveModel>> getAllUsers() async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var users = box.values.toList();
    box.close();
    return users;
  }

  //Login
  Future<UserHiveModel?> signInUser(String username, String password) async {
    var box = await Hive.openBox<UserHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  // ======================== News Queries ========================
  Future<void> addNews(List<NewsHiveModel> news) async {
    final box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
    for (var newsItem in news) {
      box.put(newsItem.newsid, newsItem);
    }
    box.close();
  }

  Future<List<NewsHiveModel>> getNews() async {
    await init(); // Ensure Hive is initialized before opening the box
    final box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
    var news = box.values.toList().cast<NewsHiveModel>();
    box.close();
    return news;
  }

  Future<void> clearNews() async {
    final box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
    box.clear();
  }

  // ======================== Close Hive ========================
  Future<void> closeHive() async {
    await Hive.close();
  }

  // ======================== Delete Hive ========================
  Future<void> deleteHive() async {
    var directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.newsBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.vehiclesBox);
    await Hive.deleteFromDisk();
  }
}
