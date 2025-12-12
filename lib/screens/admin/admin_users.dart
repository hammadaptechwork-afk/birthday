import 'package:flutter/material.dart';

class AdminUsersScreen extends StatelessWidget {
  const AdminUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      _UserItem('John Doe', 'john@example.com', 'Premium', true),
      _UserItem('Jane Smith', 'jane@example.com', 'Standard', false),
      _UserItem('Robert Johnson', 'robert@example.com', 'Premium', true),
      _UserItem('Sarah Williams', 'sarah@example.com', 'Standard', false),
      _UserItem('Michael Brown', 'michael@example.com', 'Admin', true),
    ];

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: Text(
                  user.name[0],
                  style: const TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Chip(
                    label: Text(
                      user.type,
                      style: TextStyle(
                        color: user.type == 'Admin' ? Colors.red : Colors.blue,
                        fontSize: 10,
                      ),
                    ),
                    backgroundColor: user.type == 'Admin'
                        ? Colors.red.shade50
                        : Colors.blue.shade50,
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    user.isActive ? Icons.check_circle : Icons.remove_circle,
                    color: user.isActive ? Colors.green : Colors.grey,
                    size: 20,
                  ),
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(user.name),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Email: ${user.email}'),
                        Text('Type: ${user.type}'),
                        Text('Status: ${user.isActive ? 'Active' : 'Inactive'}'),
                        const SizedBox(height: 16),
                        if (user.type != 'Admin')
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Make Admin'),
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
}

class _UserItem {
  final String name;
  final String email;
  final String type;
  final bool isActive;

  _UserItem(this.name, this.email, this.type, this.isActive);
}