import 'package:flutter/material.dart';

class CoreScreen extends StatelessWidget {
  final String name;
  final String occupation;

  const CoreScreen({
    super.key,
    required this.name,
    required this.occupation,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Image.asset(
                  'assets/images/ggtdd.png',
                  width: 115,
                  height: 55,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(height: 60),
            Center(
              child: Text(
                '$name님,\n당신의 직업은 $occupation입니다.',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
