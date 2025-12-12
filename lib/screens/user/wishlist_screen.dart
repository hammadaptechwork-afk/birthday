import 'package:flutter/material.dart';
import 'package:watchhub/models/product.dart';
import 'package:watchhub/screens/user/product_detail_screen.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = [
      WishlistItem('1', 'Rolex Submariner', 'Rolex', 8999.99, 8499.99),
      WishlistItem('2', 'Omega Speedmaster', 'Omega', 5999.99, null),
      WishlistItem('3', 'Apple Watch Ultra', 'Apple', 799.99, null),
      WishlistItem('4', 'Tag Heuer Carrera', 'Tag Heuer', 3999.99, 3599.99),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Wishlist'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Clear Wishlist'),
                  content: const Text('Remove all items from wishlist?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: products.isEmpty
          ? const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 100, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'Your wishlist is empty',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Save items you love for later',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.watch, color: Colors.grey),
              ),
              title: Text(
                product.name,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                product.brand,
                style: const TextStyle(color: Colors.grey),
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${product.currentPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.blue,
                    ),
                  ),
                  if (product.discountPrice != null)
                    Text(
                      '\$${product.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailScreen(
                      product: Product(
                        id: product.id,
                        name: product.name,
                        brand: product.brand,
                        description: 'Luxury watch',
                        price: product.price,
                        discountPrice: product.discountPrice,
                        category: 'Luxury',
                        stock: 10,
                        rating: 4.8,
                        reviewCount: 125,
                        isFeatured: true,
                        images: [],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class WishlistItem {
  final String id;
  final String name;
  final String brand;
  final double price;
  final double? discountPrice;

  WishlistItem(this.id, this.name, this.brand, this.price, this.discountPrice);

  double get currentPrice => discountPrice ?? price;
}
