import 'package:flutter/material.dart';
import 'package:watchhub/screens/admin/admin_orders.dart';
import 'package:watchhub/screens/admin/admin_products.dart';
import 'package:watchhub/screens/admin/admin_users.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const DashboardHome(),
    const AdminProductsScreen(),
    const AdminOrdersScreen(),
    const AdminUsersScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.admin_panel_settings,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Admin Panel',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'WatchHub Management',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.dashboard),
              title: const Text('Dashboard'),
              selected: _selectedIndex == 0,
              onTap: () => _selectPage(0),
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Products'),
              selected: _selectedIndex == 1,
              onTap: () => _selectPage(1),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Orders'),
              selected: _selectedIndex == 2,
              onTap: () => _selectPage(2),
            ),
            ListTile(
              leading: const Icon(Icons.people),
              title: const Text('Users'),
              selected: _selectedIndex == 3,
              onTap: () => _selectPage(3),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Exit Admin'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex],
    );
  }

  void _selectPage(int index) {
    setState(() => _selectedIndex = index);
    Navigator.pop(context);
  }
}

class DashboardHome extends StatelessWidget {
  const DashboardHome({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Stats Grid
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              _buildStatCard(
                title: 'Total Revenue',
                value: '\$24,580',
                icon: Icons.attach_money,
                color: Colors.green,
              ),
              _buildStatCard(
                title: 'Total Orders',
                value: '156',
                icon: Icons.shopping_cart,
                color: Colors.blue,
              ),
              _buildStatCard(
                title: 'Total Products',
                value: '42',
                icon: Icons.inventory,
                color: Colors.orange,
              ),
              _buildStatCard(
                title: 'Total Users',
                value: '1,234',
                icon: Icons.people,
                color: Colors.purple,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Recent Orders
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Recent Orders',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildOrderItem('ORD-001', 'John Doe', '\$899.99', 'Processing'),
                  _buildOrderItem('ORD-002', 'Jane Smith', '\$1,599.99', 'Shipped'),
                  _buildOrderItem('ORD-003', 'Robert Johnson', '\$2,499.99', 'Delivered'),
                  _buildOrderItem('ORD-004', 'Sarah Williams', '\$599.99', 'Pending'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Quick Actions
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Quick Actions',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildActionButton(Icons.add, 'Add Product', () {}),
                      _buildActionButton(Icons.edit, 'Edit Products', () {}),
                      _buildActionButton(Icons.local_shipping, 'Process Orders', () {}),
                      _buildActionButton(Icons.analytics, 'View Analytics', () {}),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: color),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String orderId, String customer, String amount, String status) {
    Color statusColor = Colors.grey;
    if (status == 'Processing') statusColor = Colors.orange;
    if (status == 'Shipped') statusColor = Colors.blue;
    if (status == 'Delivered') statusColor = Colors.green;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: statusColor.withOpacity(0.1),
        child: Icon(
          Icons.shopping_cart,
          color: statusColor,
        ),
      ),
      title: Text(orderId),
      subtitle: Text(customer),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            amount,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 4),
          Chip(
            label: Text(
              status,
              style: TextStyle(
                color: statusColor,
                fontSize: 10,
              ),
            ),
            backgroundColor: statusColor.withOpacity(0.1),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }
}