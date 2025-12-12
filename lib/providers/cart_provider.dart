import 'package:flutter/material.dart';
import 'package:watchhub/models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  List<CartItem> _cartItems = [];
  double _shippingCharge = 5.99;
  double _taxRate = 0.08;

  List<CartItem> get cartItems => _cartItems;
  int get itemCount => _cartItems.fold(0, (sum, item) => sum + item.quantity);
  double get subtotal => _cartItems.fold(0, (sum, item) => sum + item.totalPrice);
  double get shipping => _shippingCharge;
  double get tax => subtotal * _taxRate;
  double get total => subtotal + shipping + tax;

  bool get isEmpty => _cartItems.isEmpty;
  bool get isNotEmpty => _cartItems.isNotEmpty;

  void addToCart(CartItem item) {
    final existingIndex = _cartItems.indexWhere(
          (cartItem) => cartItem.productId == item.productId,
    );

    if (existingIndex >= 0) {
      _cartItems[existingIndex].quantity += 1;
    } else {
      _cartItems.add(item);
    }
    notifyListeners();
  }

  void removeFromCart(String id) {
    _cartItems.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int quantity) {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      if (quantity <= 0) {
        _cartItems.removeAt(index);
      } else {
        _cartItems[index].quantity = quantity;
      }
      notifyListeners();
    }
  }

  void incrementQuantity(String id) {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index >= 0) {
      _cartItems[index].quantity += 1;
      notifyListeners();
    }
  }

  void decrementQuantity(String id) {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index >= 0 && _cartItems[index].quantity > 1) {
      _cartItems[index].quantity -= 1;
      notifyListeners();
    }
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  bool isInCart(String productId) {
    return _cartItems.any((item) => item.productId == productId);
  }
}