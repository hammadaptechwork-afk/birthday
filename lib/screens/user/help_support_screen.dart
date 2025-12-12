import 'package:flutter/material.dart';

class HelpSupportScreen extends StatelessWidget {
  HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Help & Support"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Need Help?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              "If you have any questions or issues, feel free to reach out. "
                  "You can contact us through email or chat support.",
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Add your contact logic here
              },
              child: const Text("Contact Support"),
            ),
          ],
        ),
      ),
    );
  }
}
