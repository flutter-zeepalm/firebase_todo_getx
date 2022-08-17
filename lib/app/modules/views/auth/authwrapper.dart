import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../home_view.dart';
import 'login.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          User? user = snapshot.data;
          return user == null ? LoginPage() : HomeView();
        });
  }
}
