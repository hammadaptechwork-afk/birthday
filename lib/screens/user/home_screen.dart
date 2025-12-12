import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/providers/cart_provider.dart';
import 'package:watchhub/providers/product_provider.dart';
import 'package:watchhub/providers/user_provider.dart';
import 'package:watchhub/screens/admin/admin_dashboard.dart';
import 'package:watchhub/screens/user/cart_screen.dart';
import 'package:watchhub/screens/user/product_detail_screen.dart';
import 'package:watchhub/screens/user/profile_screen.dart';
import 'package:watchhub/widgets/product_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _categories = [
    'All',
    'Luxury',
    'Chronograph',
    'Smart',
    'Sport'
  ];
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WatchHub'),
        centerTitle: true,
        actions: [
          if (userProvider.isAdmin)
            IconButton(
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AdminDashboard(),
                  ),
                );
              },
            ),
          IconButton(
            icon: Badge(
              label: Text(cartProvider.itemCount.toString()),
              isLabelVisible: cartProvider.isNotEmpty,
              child: const Icon(Icons.shopping_cart),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CartScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search watches...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              onChanged: productProvider.searchProducts,
            ),
          ),

          // Categories
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                return Padding(
                  padding: EdgeInsets.only(
                    left: index == 0 ? 16 : 8,
                    right: index == _categories.length - 1 ? 16 : 8,
                  ),
                  child: ChoiceChip(
                    label: Text(category),
                    selected: productProvider.selectedCategory == category,
                    onSelected: (selected) {
                      productProvider.filterByCategory(category);
                    },
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Products Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.7,
                ),
                itemCount: productProvider.filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = productProvider.filteredProducts[index];
                  return ProductCard(
                    product: product,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ProductDetailScreen(product: product),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
        ],
      ),
    );
  }
}