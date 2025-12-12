import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:watchhub/providers/user_provider.dart';
import 'package:watchhub/screens/user//address_book_screen.dart';

// Your import style with double slash
import 'package:watchhub/screens/user//orders_screen.dart';
import 'package:watchhub/screens/user//wishlist_screen.dart';
import 'package:watchhub/screens/user//payment_methods_screen.dart';
import 'package:watchhub/screens/user//settings_screen.dart';
import 'package:watchhub/screens/user//help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.blue.shade100,
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProvider.currentUser?.name ?? 'Guest User',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          userProvider.currentUser?.email ?? 'guest@example.com',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (userProvider.currentUser?.isAdmin == true)
                          Chip(
                            label: const Text(
                              'Admin',
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red,
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Menu Items
          _buildMenuItem(
            icon: Icons.shopping_bag,
            title: 'My Orders',
            subtitle: 'View your order history',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const OrdersScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.favorite,
            title: 'Wishlist',
            subtitle: 'View saved items',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.location_on,
            title: 'Address Book',
            subtitle: 'Manage shipping addresses',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => AddressBookScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.credit_card,
            title: 'Payment Methods',
            subtitle: 'Manage payment options',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentMethodsScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.settings,
            title: 'Settings',
            subtitle: 'App preferences',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.help,
            title: 'Help & Support',
            subtitle: 'Get help with your account',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HelpSupportScreen()),
              );
            },
          ),

          const SizedBox(height: 32),

          // Logout Button
          if (userProvider.isLoggedIn)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Log Out'),
                      content: const Text('Are you sure you want to log out?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            userProvider.logout();
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade50,
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Log Out'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: const TextStyle(color: Colors.grey)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}