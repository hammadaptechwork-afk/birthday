import 'package:flutter/material.dart';
import 'package:watchhub/models/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _filteredProducts = [];
  String _selectedCategory = 'All';

  List<Product> get products => _products;
  List<Product> get filteredProducts => _filteredProducts;
  String get selectedCategory => _selectedCategory;

  ProductProvider() {
    _initializeProducts();
  }

  void _initializeProducts() {
    _products = [
      Product(
        id: '1',
        name: 'Rolex Submariner',
        brand: 'Rolex',
        description: 'Luxury diving watch with automatic movement',
        price: 8999.99,
        discountPrice: 8499.99,
        category: 'Luxury',
        stock: 10,
        rating: 4.8,
        reviewCount: 125,
        isFeatured: true,
        images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49'],
      ),
      Product(
        id: '2',
        name: 'Omega Speedmaster',
        brand: 'Omega',
        description: 'Moonwatch professional chronograph',
        price: 5999.99,
        category: 'Chronograph',
        stock: 15,
        rating: 4.9,
        reviewCount: 89,
        isFeatured: true,
        images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49'],
      ),
      Product(
        id: '3',
        name: 'Apple Watch Ultra',
        brand: 'Apple',
        description: 'Advanced smartwatch for athletes',
        price: 799.99,
        category: 'Smart',
        stock: 50,
        rating: 4.7,
        reviewCount: 342,
        isFeatured: true,
        images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49'],
      ),
      Product(
        id: '4',
        name: 'Tag Heuer Carrera',
        brand: 'Tag Heuer',
        description: 'Sporty chronograph with elegant design',
        price: 3999.99,
        discountPrice: 3599.99,
        category: 'Sport',
        stock: 25,
        rating: 4.5,
        reviewCount: 67,
        isFeatured: false,
        images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49'],
      ),
      Product(
        id: '5',
        name: 'Patek Philippe Nautilus',
        brand: 'Patek Philippe',
        description: 'Ultra-luxury sports watch',
        price: 59999.99,
        category: 'Luxury',
        stock: 5,
        rating: 4.9,
        reviewCount: 42,
        isFeatured: true,
        images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49'],
      ),
      Product(
        id: '6',
        name: 'Casio G-Shock',
        brand: 'Casio',
        description: 'Durable and shock-resistant watch',
        price: 199.99,
        category: 'Sport',
        stock: 100,
        rating: 4.4,
        reviewCount: 256,
        isFeatured: false,
        images: ['https://images.unsplash.com/photo-1523170335258-f5ed11844a49'],
      ),
    ];

    _filteredProducts = _products;
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    if (category == 'All') {
      _filteredProducts = _products;
    } else {
      _filteredProducts = _products
          .where((product) => product.category == category)
          .toList();
    }
    notifyListeners();
  }

  void searchProducts(String query) {
    if (query.isEmpty) {
      filterByCategory(_selectedCategory);
    } else {
      _filteredProducts = _products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase()) ||
            product.brand.toLowerCase().contains(query.toLowerCase()) ||
            product.description.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    notifyListeners();
  }

  Product? getProductById(String id) {
    return _products.firstWhere(
          (product) => product.id == id,
      orElse: () => Product(
        id: '',
        name: '',
        brand: '',
        description: '',
        price: 0,
        category: '',
        stock: 0,
        images: [],
      ),
    );
  }

  List<String> getCategories() {
    final categories = _products.map((p) => p.category).toSet().toList();
    return ['All', ...categories];
  }

  List<Product> getFeaturedProducts() {
    return _products.where((product) => product.isFeatured).toList();
  }
}