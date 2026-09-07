import 'package:dio/dio.dart';

import '../models/product_model.dart';
import '../../../../core/network/dio_client.dart';

class ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSource(this.dioClient);

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await dioClient.dio.get(
        '/products',
        queryParameters: {'select': '*', 'order': 'created_at.desc'},
      );

      final data = response.data as List;

      return data
          .map((json) => ProductModel.fromJson(json as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception('Impossible de récupérer les produits : ${e.message}');
    } catch (e) {
      throw Exception('Une erreur est survenue : $e');
    }
  }
}
