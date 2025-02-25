import 'package:college_connect_canteen/features/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void checkLogin(BuildContext context) {
  Future.delayed(
      const Duration(
        milliseconds: 100,
      ), () {
    User? currentUser = Supabase.instance.client.auth.currentUser;
    if (!(currentUser != null &&
        (currentUser.appMetadata['role'] == 'admin'))) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  });
}
