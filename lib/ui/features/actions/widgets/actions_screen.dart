import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/bottom_nav_bar.dart';

class ActionsScreen extends StatelessWidget {
  ActionsScreen({super.key});

  final List<Map<String, String>> actions = [
    {'id': '1', 'title': 'Finish presentation'},
    {'id': '2', 'title': 'Send email to team'},
    {'id': '3', 'title': 'Plan next sprint'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '액션',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const SizedBox(
            width: 36,
            height: 36,
            child: ImageIcon(AssetImage('assets/icons/chevron left.png')),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Your Action Steps',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: actions.length,
                  itemBuilder: (context, index) {
                    final action = actions[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(action['title']!),
                        subtitle: Text('ID: ${action['id']}'),
                        onTap: () {
                          Get.toNamed('/actions/${action['id']}');
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 3),
    );
  }
}
