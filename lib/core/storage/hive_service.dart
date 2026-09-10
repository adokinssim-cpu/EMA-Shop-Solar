import 'package:hive_flutter/hive_flutter.dart';

import 'cache_constants.dart';

class HiveService {
  HiveService._();

  static Future<void> init() async {
    await Hive.initFlutter();

    await Hive.openBox(CacheConstants.productsBox);

    await Hive.openBox(CacheConstants.favoritesBox);

    await Hive.openBox(CacheConstants.userBox);
  }

  static Box get productsBox => Hive.box(CacheConstants.productsBox);

  static Box get favoritesBox => Hive.box(CacheConstants.favoritesBox);

  static Box get userBox => Hive.box(CacheConstants.userBox);
}
