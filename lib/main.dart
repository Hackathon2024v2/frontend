import 'package:flutter/material.dart';
import 'package:flutter_application_2/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

const supabaseUrl = 'https://xznwmygmnxintzawgghd.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Inh6bndteWdtbnhpbnR6YXdnZ2hkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIzNzY3MjYsImV4cCI6MjA0Nzk1MjcyNn0.51tNyUvk1c5BoMrgguEdfI8_GxzPaVTx1ky3AGB-mcY';
const Color color = Color(0xFF8a6952);

void main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: color),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

