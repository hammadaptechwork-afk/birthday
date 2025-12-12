import 'package:flutter/material.dart';

class AddressBookScreen extends StatelessWidget {
  AddressBookScreen({super.key});

  final List<String> savedAddresses = const [
    "123 Main Street, City A",
    "45 Sunset Road, City B",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Address Book"),
      ),
      body: ListView.builder(
        itemCount: savedAddresses.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.location_on),
            title: Text(savedAddresses[index]),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Add edit address logic
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // Add new address logic
        },
      ),
    );
  }
}
