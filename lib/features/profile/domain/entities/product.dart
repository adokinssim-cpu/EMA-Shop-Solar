class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final double? power;
  final double? voltage;
  final String? imageUrl;
  final int stock;
  final double rating;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.power,
    this.voltage,
    this.imageUrl,
    required this.stock,
    required this.rating,
  });
}
