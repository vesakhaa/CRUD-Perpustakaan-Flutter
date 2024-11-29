import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:library_management/pages/homepage.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://wcycmxapinblsrixnwvi.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndjeWNteGFwaW5ibHNyaXhud3ZpIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE3MjY1NzUsImV4cCI6MjA0NzMwMjU3NX0.cOwVjeJXoiwWE-39rr1A9P1yFKx4eOnM47VsY_0V3ik',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Digital Library',
      debugShowCheckedModeBanner: false,
      home: BookListPage(),
    );
  }
}
