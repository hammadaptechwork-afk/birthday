class Product {
  final String id;
  final String name;
  final String brand;
  final String description;
  final double price;
  final double? discountPrice;
  final String category;
  final int stock;
  final double rating;
  final int reviewCount;
  final bool isFeatured;
  final List<String> images;

  Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.description,
    required this.price,
    this.discountPrice,
    required this.category,
    required this.stock,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFeatured = false,
    required this.images,
  });

  double get currentPrice => discountPrice ?? price;
  double get discountPercentage => discountPrice != null
      ? ((price - discountPrice!) / price * 100)
      : 0.0;
}