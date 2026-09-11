import 'package:ema_shop_solar/features/products/domain/entities/product.dart';
import 'package:ema_shop_solar/features/profile/domain/repositories/product_repository.dart';

class GetProducts {
  final ProductRepository repository;

  GetProducts(this.repository);

  Future<List<Product>> call() async {
    return await repository.getProducts();
  }
}
