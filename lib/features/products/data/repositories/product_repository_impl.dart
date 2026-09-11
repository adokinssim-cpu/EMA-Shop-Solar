import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_local_data_source.dart';
import '../datasources/product_remote_data_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Product>> getProducts({int page = 1, int limit = 10}) async {
    try {
      final products = await remoteDataSource.getProducts(
        page: page,
        limit: limit,
      );

      if (page == 1) {
        await localDataSource.cacheProducts(products);
      }

      return products;
    } catch (_) {
      if (page == 1) {
        final cachedProducts = localDataSource.getCachedProducts();

        if (cachedProducts.isNotEmpty) {
          return cachedProducts;
        }
      }

      rethrow;
    }
  }

  @override
  Future<Product> getProductById(String id) async {
    try {
      return await remoteDataSource.getProductById(id);
    } catch (_) {
      final cachedProducts = localDataSource.getCachedProducts();

      return cachedProducts.firstWhere(
        (product) => product.id == id,
        orElse: () {
          throw Exception('Produit introuvable.');
        },
      );
    }
  }
}
