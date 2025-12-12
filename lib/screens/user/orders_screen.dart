import 'package:flutter/material.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      _OrderItem('ORD-001', 'Dec 15, 2024', '\$899.99', 'Delivered'),
      _OrderItem('ORD-002', 'Dec 10, 2024', '\$1,599.99', 'Shipped'),
      _OrderItem('ORD-003', 'Dec 5, 2024', '\$2,499.99', 'Processing'),
      _OrderItem('ORD-004', 'Nov 28, 2024', '\$599.99', 'Delivered'),
      _OrderItem('ORD-005', 'Nov 20, 2024', '\$3,299.99', 'Cancelled'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        order.orderId,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Chip(
                        label: Text(
                          order.status,
                          style: TextStyle(
                            color: _getStatusColor(order.status),
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: _getStatusColor(order.status).withOpacity(0.1),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Order Date: ${order.date}',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Amount',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        order.amount,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          child: const Text('View Details'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      if (order.status == 'Delivered')
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: const Text('Reorder'),
                          ),
                        ),
                      if (order.status == 'Processing')
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('Cancel'),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return Colors.green;
      case 'Shipped':
        return Colors.blue;
      case 'Processing':
        return Colors.orange;
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

class _OrderItem {
  final String orderId;
  final String date;
  final String amount;
  final String status;

  _OrderItem(this.orderId, this.date, this.amount, this.status);
}