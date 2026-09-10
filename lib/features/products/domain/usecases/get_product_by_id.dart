import '../entities/product.dart';
import '../repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  const GetProducts(this.repository);

  Future<List<Product>> call({int page = 1, int limit = 10}) {
    return repository.getProducts(page: page, limit: limit);
  }
}
