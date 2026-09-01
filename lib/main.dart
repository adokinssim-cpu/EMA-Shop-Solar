import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://lpqafscddalkdahfkfxy.supabase.co',
    publishableKey: 'sb_publishable_oPYi435V3A8PgC5MmMdalg_gpZna_GJ',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMA Shop',
      home: Scaffold(
        appBar: AppBar(title: const Text('EMA Shop')),
        body: const Center(child: Text('Connexion à Supabase réussie 🚀')),
      ),
    );
  }
}
