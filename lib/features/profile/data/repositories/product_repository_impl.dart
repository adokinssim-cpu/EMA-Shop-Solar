import 'package:ema_shop_solar/features/profile/data/datasources/product_local_data_source.dart';
import 'package:ema_shop_solar/features/profile/data/datasources/product_remote_data_source.dart';
import 'package:ema_shop_solar/features/products/domain/entities/product.dart';
import 'package:ema_shop_solar/features/profile/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      final remoteData = await remoteDataSource.fetchProducts();
      await localDataSource.cacheProducts(remoteData);

      return remoteData
          .map(
            (json) => Product(
              id: json['id'].toString(),
              name: json['name'] ?? '',
              price: (json['price'] as num?)?.toDouble() ?? 0.0,
              description: json['description'] ?? '',
              category: json['category'] ?? '',
              stock: (json['stock'] as num?)?.toInt() ?? 0,
              rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
              imageUrl: json['imageUrl'] ?? '',
            ),
          )
          .toList();
    } catch (_) {
      final cachedData = localDataSource.getCachedProducts();
      if (cachedData != null) {
        return cachedData
            .map(
              (json) => Product(
                id: json['id'].toString(),
                name: json['name'] ?? '',
                price: (json['price'] as num?)?.toDouble() ?? 0.0,
                description: json['description'] ?? '',
                category: json['category'] ?? '',
                stock: (json['stock'] as num?)?.toInt() ?? 0,
                rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
                imageUrl: json['imageUrl'] ?? '',
              ),
            )
            .toList();
      }
      rethrow;
    }
  }
}
