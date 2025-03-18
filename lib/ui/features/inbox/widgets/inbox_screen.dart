import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ggtdd_frontend/ui/core/bottom_nav_bar.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({super.key});

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> {
  final TextEditingController _controller = TextEditingController();
  List<String> inboxItems = [
    'Prepare presentation slides',
    'Email client about meeting',
    'Brainstorm new project ideas',
  ];

  void _addItem() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        inboxItems.add(_controller.text);
        _controller.clear();
      });
      FocusScope.of(context).unfocus();
    } else {
      Get.snackbar('Error', 'Please enter something');
    }
  }

  void _deleteItem(int index) {
    setState(() {
      inboxItems.removeAt(index);
    });
    Get.snackbar('Deleted', 'Item removed');
  }

  void _editItem(int index) {
    TextEditingController editController =
        TextEditingController(text: inboxItems[index]);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Item'),
        content: TextField(
          controller: editController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Edit your item',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (editController.text.isNotEmpty) {
                setState(() {
                  inboxItems[index] = editController.text;
                });
                Navigator.pop(context);
                Get.snackbar('Updated', 'Item modified');
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '수집',
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
                'Your Inbox',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: inboxItems.isEmpty
                    ? const Center(child: Text('No items yet'))
                    : ListView.builder(
                        itemCount: inboxItems.length,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(inboxItems[index]),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () => _editItem(index),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () => _deleteItem(index),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
              // Recognition으로 이동하는 버튼 추가
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed('/recognition');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Process in Recognition',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              // 입력 필드와 추가 버튼
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Add a new item',
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (_) => _addItem(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: _addItem,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const AppBottomNavBar(currentIndex: 1),
    );
  }
}
