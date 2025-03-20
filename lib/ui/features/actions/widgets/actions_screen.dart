import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/widgets/bottom_nav_bar.dart';
import 'package:gap/gap.dart';

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
      appBar: AppBar(title: const Text('Actions')),
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
              const Gap(20),
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
