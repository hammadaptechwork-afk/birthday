class Order {
  final String id;
  final String userId;
  final List<CartItem> items;
  final double totalAmount;
  final String status;
  final DateTime orderDate;
  final String shippingAddress;
  final String paymentMethod;

  Order({
    required this.id,
    required this.userId,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.orderDate,
    required this.shippingAddress,
    required this.paymentMethod,
  });
}