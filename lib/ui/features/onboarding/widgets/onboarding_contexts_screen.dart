import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class OnBoardingContextsScreen extends StatefulWidget {
  const OnBoardingContextsScreen({super.key});

  @override
  State<OnBoardingContextsScreen> createState() =>
      _OnBoardingContextsScreenState();
}

class _OnBoardingContextsScreenState extends State<OnBoardingContextsScreen> {
  String? selectedContext;

  final List<String> contexts = ['Student', 'Developer', 'Designer', 'Manager'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding - Contexts')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'What’s your main context?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const Gap(20),
              DropdownButtonFormField<String>(
                value: selectedContext,
                hint: const Text('Select your context'),
                items: contexts.map((String context) {
                  return DropdownMenuItem<String>(
                    value: context,
                    child: Text(context),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedContext = newValue;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              const Gap(30),
              ElevatedButton(
                onPressed: () {
                  if (selectedContext != null) {
                    Get.toNamed('/inbox');
                  } else {
                    Get.snackbar('Error', 'Please select a context');
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Finish',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Gap(20),
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Back to Info'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
