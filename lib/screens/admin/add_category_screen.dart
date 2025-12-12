import 'package:flutter/material.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedIcon;

  final List<Map<String, dynamic>> _icons = [
    {'icon': Icons.watch, 'label': 'Watch'},
    {'icon': Icons.luxury, 'label': 'Luxury'},
    {'icon': Icons.sports, 'label': 'Sports'},
    {'icon': Icons.smart_display, 'label': 'Smart'},
    {'icon': Icons.access_time, 'label': 'Time'},
    {'icon': Icons.diamond, 'label': 'Premium'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Image/Icon
              const Text(
                'Category Icon',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: _icons.map((iconData) {
                  final icon = iconData['icon'] as IconData;
                  final isSelected = _selectedIcon == iconData['label'];
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedIcon = iconData['label']);
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.blue.shade100
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(icon,
                              size: 30,
                              color: isSelected ? Colors.blue : Colors.grey),
                          const SizedBox(height: 4),
                          Text(
                            iconData['label'],
                            style: TextStyle(
                              fontSize: 10,
                              color: isSelected ? Colors.blue : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 24),

              // Category Name
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Category Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter category name';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 32),

              // Status Switch
              Row(
                children: [
                  Switch(value: true, onChanged: (value) {}),
                  const SizedBox(width: 8),
                  const Text('Active'),
                  const Spacer(),
                  Switch(value: false, onChanged: (value) {}),
                  const SizedBox(width: 8),
                  const Text('Featured'),
                ],
              ),

              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (_selectedIcon == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please select an icon'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // Save category logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Category added successfully'),
                          backgroundColor: Colors.green,
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Add Category',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}