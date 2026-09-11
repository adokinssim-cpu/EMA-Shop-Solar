import 'package:ema_shop_solar/features/products/data/datasources/product_local_data_source.dart';
import 'package:ema_shop_solar/features/products/data/datasources/product_remote_data_source.dart';
import 'package:ema_shop_solar/features/products/data/repositories/product_repository_impl.dart';
import 'package:ema_shop_solar/features/products/domain/entities/product.dart';
import 'package:ema_shop_solar/features/products/domain/repositories/product_repository.dart';
import 'package:ema_shop_solar/features/products/domain/usecases/get_product_by_id.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/dio_client.dart';

final dioClientProvider = Provider<DioClient>((ref) {
  return DioClient(
    baseUrl: '${ApiConstants.supabaseUrl}/rest/v1',
    apiKey: ApiConstants.supabaseAnonKey,
  );
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  return ProductRemoteDataSource(ref.watch(dioClientProvider));
});

final productLocalDataSourceProvider = Provider<ProductLocalDataSource>((ref) {
  return ProductLocalDataSource();
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(
    remoteDataSource: ref.watch(productRemoteDataSourceProvider),
    localDataSource: ref.watch(productLocalDataSourceProvider),
  );
});

final getProductsProvider = Provider<GetProducts>((ref) {
  return GetProducts(ref.watch(productRepositoryProvider));
});

final productsProvider =
    StateNotifierProvider<ProductsNotifier, AsyncValue<List<Product>>>((ref) {
      return ProductsNotifier(ref.watch(getProductsProvider));
    });

class ProductsNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final GetProducts getProducts;

  int _currentPage = 1;

  static const int _pageSize = 10;

  ProductsNotifier(this.getProducts) : super(const AsyncLoading()) {
    loadProducts();
  }

  Future<void> loadProducts() async {
    state = const AsyncLoading();

    try {
      _currentPage = 1;

      final products = await getProducts(page: _currentPage, limit: _pageSize);

      state = AsyncData(products.cast<Product>());
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> loadNextPage() async {
    if (state is! AsyncData<List<Product>>) {
      return;
    }

    try {
      final nextPage = _currentPage + 1;

      final newProducts = await getProducts(page: nextPage, limit: _pageSize);

      if (newProducts.isEmpty) {
        return;
      }

      final currentProducts = (state as AsyncData<List<Product>>).value;

      _currentPage = nextPage;

      state = AsyncData([...currentProducts, ...newProducts]);
    } catch (e, stackTrace) {
      state = AsyncError(e, stackTrace);
    }
  }

  Future<void> refreshProducts() async {
    await loadProducts();
  }
}
