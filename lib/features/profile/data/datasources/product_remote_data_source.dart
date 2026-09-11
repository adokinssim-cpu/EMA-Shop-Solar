import 'package:supabase_flutter/supabase_flutter.dart';

class ProductRemoteDataSource {
  final SupabaseClient supabaseClient;

  ProductRemoteDataSource(this.supabaseClient);

  Future<List<Map<String, dynamic>>> fetchProducts() async {
    final response = await supabaseClient.from('products').select();
    return List<Map<String, dynamic>>.from(response);
  }
}
