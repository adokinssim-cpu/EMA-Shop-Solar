import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMA Shop Solar',
      home: Scaffold(
        appBar: AppBar(title: const Text('EMA Shop Solar')),
        body: const Center(child: Text('EMA Shop Solar 🚀')),
      ),
    );
  }
}
