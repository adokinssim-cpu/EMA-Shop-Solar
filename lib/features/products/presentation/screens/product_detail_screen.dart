import 'package:ema_shop_solar/features/products/presentation/providers/product_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/formatters.dart';
import '../../domain/entities/product.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<ProductDetailScreen> createState() =>
      _ProductDetailScreenState();
}

class _ProductDetailScreenState extends ConsumerState<ProductDetailScreen> {
  Product? product;
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadProduct();
  }

  Future<void> _loadProduct() async {
    try {
      final repository = ref.read(productRepositoryProvider);

      final result = await repository.getProductById(widget.productId);

      if (!mounted) return;

      setState(() {
        product = result;
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage = 'Impossible de charger le produit.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Détails du produit')),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (errorMessage != null) {
      return Center(child: Text(errorMessage!));
    }

    if (product == null) {
      return const Center(child: Text('Produit introuvable.'));
    }

    final item = product!;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (item.imageUrl.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) {
                  return const SizedBox(
                    height: 250,
                    child: Center(child: Icon(Icons.broken_image, size: 50)),
                  );
                },
              ),
            ),

          const SizedBox(height: 20),

          Text(
            item.name,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),

          Text(item.category, style: TextStyle(color: Colors.grey.shade600)),

          const SizedBox(height: 16),

          Text(
            Formatters.formatPrice(item.price),
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          Text(
            item.description,
            style: const TextStyle(fontSize: 16, height: 1.5),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              const Icon(Icons.star),
              const SizedBox(width: 6),
              Text(item.rating.toStringAsFixed(1)),
              const SizedBox(width: 24),
              Text('Stock : ${item.stock}'),
            ],
          ),
        ],
      ),
    );
  }
}
