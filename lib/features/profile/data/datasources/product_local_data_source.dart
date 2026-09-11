import 'package:hive/hive.dart';

class ProductLocalDataSource {
  static const String boxName = 'products_box';

  Future<void> cacheProducts(List<Map<String, dynamic>> products) async {
    final box = await Hive.openBox(boxName);
    await box.put('cached_products', products);
  }

  List<Map<String, dynamic>>? getCachedProducts() {
    final box = Hive.box(boxName);
    final data = box.get('cached_products');
    if (data != null) {
      return List<Map<String, dynamic>>.from(data);
    }
    return null;
  }
}
