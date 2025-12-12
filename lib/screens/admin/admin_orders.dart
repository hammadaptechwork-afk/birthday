import 'package:flutter/material.dart';

class AdminOrdersScreen extends StatelessWidget {
  const AdminOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      _OrderItem('ORD-001', 'John Doe', '\$899.99', 'Processing'),
      _OrderItem('ORD-002', 'Jane Smith', '\$1,599.99', 'Shipped'),
      _OrderItem('ORD-003', 'Robert Johnson', '\$2,499.99', 'Delivered'),
      _OrderItem('ORD-004', 'Sarah Williams', '\$599.99', 'Pending'),
      _OrderItem('ORD-005', 'Michael Brown', '\$3,299.99', 'Processing'),
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: _getStatusColor(order.status).withOpacity(0.1),
                child: Icon(
                  _getStatusIcon(order.status),
                  color: _getStatusColor(order.status),
                ),
              ),
              title: Text(order.orderId),
              subtitle: Text(order.customer),
              trailing: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    order.amount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Chip(
                    label: Text(
                      order.status,
                      style: TextStyle(
                        color: _getStatusColor(order.status),
                        fontSize: 10,
                      ),
                    ),
                    backgroundColor: _getStatusColor(order.status).withOpacity(0.1),
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Order ${order.orderId}'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Customer: ${order.customer}'),
                        Text('Amount: ${order.amount}'),
                        Text('Status: ${order.status}'),
                        const SizedBox(height: 16),
                        if (order.status == 'Pending')
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Process Order'),
                          ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Processing':
        return Colors.orange;
      case 'Shipped':
        return Colors.blue;
      case 'Delivered':
        return Colors.green;
      case 'Pending':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Processing':
        return Icons.sync;
      case 'Shipped':
        return Icons.local_shipping;
      case 'Delivered':
        return Icons.check_circle;
      case 'Pending':
        return Icons.pending;
      default:
        return Icons.help;
    }
  }
}

class _OrderItem {
  final String orderId;
  final String customer;
  final String amount;
  final String status;

  _OrderItem(this.orderId, this.customer, this.amount, this.status);
} 