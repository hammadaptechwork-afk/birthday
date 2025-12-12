import 'package:flutter/material.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final List<_Address> _addresses = [
    _Address(
      '1',
      'Home',
      'John Doe',
      '123 Main Street',
      'New York, NY 10001',
      '+1 (123) 456-7890',
      true,
    ),
    _Address(
      '2',
      'Office',
      'John Doe',
      '456 Business Ave',
      'New York, NY 10002',
      '+1 (123) 456-7891',
      false,
    ),
    _Address(
      '3',
      'Parents',
      'Jane Smith',
      '789 Family Road',
      'Brooklyn, NY 11201',
      '+1 (123) 456-7892',
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Address Book'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _addresses.length,
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade100,
                      child: Icon(
                        address.type == 'Home'
                            ? Icons.home
                            : address.type == 'Office'
                            ? Icons.business
                            : Icons.family_restroom,
                        color: Colors.blue,
                      ),
                    ),
                    title: Row(
                      children: [
                        Text(
                          address.type,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(width: 8),
                        if (address.isDefault)
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(address.name),
                        Text(address.addressLine1),
                        Text(address.addressLine2),
                        const SizedBox(height: 4),
                        Text(address.phone),
                      ],
                    ),
                    trailing: PopupMenuButton<String>(
                      onSelected: (value) {
                        if (value == 'edit') {
                          _editAddress(address);
                        } else if (value == 'delete') {
                          _deleteAddress(address);
                        } else if (value == 'default') {
                          _setDefault(address);
                        }
                      },
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(Icons.edit, size: 18),
                              SizedBox(width: 8),
                              Text('Edit'),
                            ],
                          ),
                        ),
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
                  _addNewAddress();
                },
                icon: const Icon(Icons.add),
                label: const Text('Add New Address'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewAddress() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Address'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address Type',
                  hintText: 'Home, Office, etc.',
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address Line 1'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Address Line 2'),
              ),
              const SizedBox(height: 12),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Phone Number'),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(value: false, onChanged: (value) {}),
                  const Text('Set as default address'),
                ],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address added successfully'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editAddress(_Address address) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editing ${address.type} address'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _deleteAddress(_Address address) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Address'),
        content: Text('Delete ${address.type} address?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _addresses.remove(address);
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Address deleted'),
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

  void _setDefault(_Address address) {
    setState(() {
      for (var addr in _addresses) {
        addr.isDefault = addr.id == address.id;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${address.type} set as default address'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class _Address {
  final String id;
  final String type;
  final String name;
  final String addressLine1;
  final String addressLine2;
  final String phone;
  bool isDefault;

  _Address(
      this.id,
      this.type,
      this.name,
      this.addressLine1,
      this.addressLine2,
      this.phone,
      this.isDefault,
      );
}