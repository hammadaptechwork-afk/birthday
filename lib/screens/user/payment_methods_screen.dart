import 'package:flutter/material.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final List<_PaymentMethod> _paymentMethods = [
    _PaymentMethod(
      '1',
      'Credit Card',
      '**** **** **** 1234',
      Icons.credit_card,
      true,
    ),
    _PaymentMethod(
      '2',
      'PayPal',
      'user@example.com',
      Icons.payment,
      false,
    ),
    _PaymentMethod(
      '3',
      'Google Pay',
      'linked account',
      Icons.account_balance_wallet,
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Methods'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _paymentMethods.length,
              itemBuilder: (context, index) {
                final method = _paymentMethods[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(method.icon, color: Colors.blue),
                    ),
                    title: Row(
                      children: [
                        Text(
                          method.type,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 8),
                        if (method.isDefault)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              'Default',
                              style: TextStyle(
                                color: Colors.green.shade700,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    subtitle: Text(method.details),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'default') {
                          _setDefault(method);
                        } else if (value == 'delete') {
                          _deleteMethod(method);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'default',
                          child: Row(
                            children: [
                              Icon(Icons.star, size: 18),
                              SizedBox(width: 8),
                              Text('Set as Default'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(Icons.delete, size: 18, color: Colors.red),
                              SizedBox(width: 8),
                              Text('Delete', style: TextStyle(color: Colors.red)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                onPressed: () {
                  _addPaymentMethod();
                },
                icon: const Icon(Icons.add),
                label: const Text('Add Payment Method'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addPaymentMethod() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Payment Method',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Card Number',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Expiry Date',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'CVV',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Cardholder Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Checkbox(value: false, onChanged: (value) {}),
                const Text('Set as default payment method'),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Payment method added successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                child: const Text('Add Card'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setDefault(_PaymentMethod method) {
    setState(() {
      for (var m in _paymentMethods) {
        m.isDefault = m.id == method.id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${method.type} set as default'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteMethod(_PaymentMethod method) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Payment Method'),
        content: Text('Delete ${method.type}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _paymentMethods.remove(method);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Payment method deleted'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod {
  final String id;
  final String type;
  final String details;
  final IconData icon;
  bool isDefault;

  _PaymentMethod(
      this.id,
      this.type,
      this.details,
      this.icon,
      this.isDefault,
      );
}