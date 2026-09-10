import 'package:ema_shop_solar/features/products/data/datasources/product_local_data_source.dart';
import 'package:ema_shop_solar/features/products/data/datasources/product_remote_data_source.dart';

import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';

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

      // On met en cache uniquement la première page.
      if (page == 1) {
        await localDataSource.cacheProducts(products);
      }

      return products;
    } catch (_) {
      // Fallback hors connexion.
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

      try {
        return cachedProducts.firstWhere((product) => product.id == id);
      } catch (_) {
        rethrow;
      }
    }
  }
}
