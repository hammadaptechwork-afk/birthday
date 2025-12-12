import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _darkMode = false;
  bool _emailUpdates = true;
  bool _smsUpdates = false;
  bool _biometricLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account Settings
          const Text(
            'Account Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Personal Information'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.lock),
                  title: const Text('Change Password'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.delete, color: Colors.red),
                  title: const Text(
                    'Delete Account',
                    style: TextStyle(color: Colors.red),
                  ),
                  trailing: const Icon(Icons.chevron_right, color: Colors.red),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Account'),
                        content: const Text(
                          'This action cannot be undone. All your data will be permanently deleted.',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // App Settings
          const Text(
            'App Settings',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Notifications'),
                  subtitle: const Text('Receive app notifications'),
                  value: _notifications,
                  onChanged: (value) {
                    setState(() => _notifications = value);
                  },
                ),
                const Divider(height: 0),
                SwitchListTile(
                  title: const Text('Dark Mode'),
                  subtitle: const Text('Enable dark theme'),
                  value: _darkMode,
                  onChanged: (value) {
                    setState(() => _darkMode = value);
                  },
                ),
                const Divider(height: 0),
                SwitchListTile(
                  title: const Text('Biometric Login'),
                  subtitle: const Text('Use fingerprint or face ID'),
                  value: _biometricLogin,
                  onChanged: (value) {
                    setState(() => _biometricLogin = value);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Notification Preferences
          const Text(
            'Notification Preferences',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                SwitchListTile(
                  title: const Text('Email Updates'),
                  subtitle: const Text('Receive email notifications'),
                  value: _emailUpdates,
                  onChanged: (value) {
                    setState(() => _emailUpdates = value);
                  },
                ),
                const Divider(height: 0),
                SwitchListTile(
                  title: const Text('SMS Updates'),
                  subtitle: const Text('Receive SMS notifications'),
                  value: _smsUpdates,
                  onChanged: (value) {
                    setState(() => _smsUpdates = value);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Support
          const Text(
            'Support',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Help Center'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.contact_support),
                  title: const Text('Contact Us'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.description),
                  title: const Text('Terms of Service'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
                const Divider(height: 0),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text('Privacy Policy'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // App Info
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'App Information',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildInfoRow('Version', '1.0.0'),
                  _buildInfoRow('Build Number', '2024.12.001'),
                  _buildInfoRow('Last Updated', 'December 15, 2024'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 32),

          // Logout Button (if logged in)
          SizedBox(
            width: double.infinity,
            height: 50,
            child: OutlinedButton(
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
                          Navigator.pop(context);
                          // Add logout logic here
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
              child: const Text(
                'Log Out',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: Colors.grey),
          ),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}