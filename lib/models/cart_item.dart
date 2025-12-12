class CartItem {
  final String id;
  final String productId;
  final String productName;
  final String productImage;
  final double price;
  int quantity;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImage,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}