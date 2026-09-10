import '../../../../core/storage/hive_service.dart';
import '../models/product_model.dart';

class ProductLocalDataSource {
  Future<void> cacheProducts(List<ProductModel> products) async {
    final box = HiveService.productsBox;

    await box.put(
      'products',
      products.map((product) => product.toJson()).toList(),
    );
  }

  List<ProductModel> getCachedProducts() {
    final box = HiveService.productsBox;

    final cachedData = box.get('products');

    if (cachedData is! List) {
      return [];
    }

    return cachedData
        .map(
          (json) =>
              ProductModel.fromJson(Map<String, dynamic>.from(json as Map)),
        )
        .toList();
  }
}
