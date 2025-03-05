import 'package:college_connect_canteen/features/login/login_screen.dart';
import 'package:college_connect_canteen/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNnaXhtaXhnamhzcHVxYXZxanN1Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzI5NDMwMjgsImV4cCI6MjA0ODUxOTAyOH0.gb43EJ1vmms_HHfdvj9bZWmAQ2Fv_qMm_yoSsjHBE8s',
      url: 'https://sgixmixgjhspuqavqjsu.supabase.co');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const Loginscreen(),
    );
  }
}
