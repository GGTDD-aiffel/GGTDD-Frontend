import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/bottom_nav_bar.dart';

class RecognitionScreen extends StatelessWidget {
  RecognitionScreen({super.key});

  final List<String> items = [
    'Prepare presentation slides',
    'Email client about meeting',
    'Brainstorm new project ideas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '구체화',
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
                'Clarify Your Items',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(items[index]),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.check),
                              onPressed: () {
                                Get.snackbar('Processed',
                                    '${items[index]} marked as actionable');
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                Get.snackbar(
                                    'Deleted', '${items[index]} removed');
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 2),
    );
  }
}
