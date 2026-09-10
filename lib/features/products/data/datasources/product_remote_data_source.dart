import 'package:dio/dio.dart';

import '../../../../core/network/dio_client.dart';
import '../models/product_model.dart';

class ProductRemoteDataSource {
  final DioClient dioClient;

  ProductRemoteDataSource(this.dioClient);

  Future<List<ProductModel>> getProducts({int page = 1, int limit = 10}) async {
    try {
      final offset = (page - 1) * limit;

      final response = await dioClient.dio.get(
        '/products',
        queryParameters: {
          'select': '*',
          'order': 'created_at.desc',
          'offset': offset,
          'limit': limit,
        },
      );

      final data = response.data;

      if (data is! List) {
        throw const FormatException('Format de réponse API invalide.');
      }

      return data
          .map(
            (json) =>
                ProductModel.fromJson(Map<String, dynamic>.from(json as Map)),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception('Erreur réseau : ${e.message}');
    } on FormatException catch (e) {
      throw Exception(e.message);
    } catch (e) {
      throw Exception('Erreur lors de la récupération des produits : $e');
    }
  }

  Future<ProductModel> getProductById(String id) async {
    try {
      final response = await dioClient.dio.get(
        '/products',
        queryParameters: {'select': '*', 'id': 'eq.$id', 'limit': 1},
      );

      final data = response.data;

      if (data is! List || data.isEmpty) {
        throw Exception('Produit introuvable.');
      }

      return ProductModel.fromJson(
        Map<String, dynamic>.from(data.first as Map),
      );
    } on DioException catch (e) {
      throw Exception('Erreur réseau : ${e.message}');
    } catch (e) {
      throw Exception('Impossible de récupérer le produit : $e');
    }
  }
}
