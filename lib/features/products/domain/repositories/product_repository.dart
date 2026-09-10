import '../entities/product.dart';

abstract class ProductRepository {
  Future<List<Product>> getProducts({int page = 1, int limit = 10});

  Future<Product> getProductById(String id);
}
