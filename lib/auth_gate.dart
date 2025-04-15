import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recout/first_page.dart';
import 'package:recout/home_page.dart';
import 'package:recout/user_state.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<void> _syncUserData(BuildContext context, User user) async {
    final prefs = await SharedPreferences.getInstance();
    if (context.mounted) {
      final uname = Provider.of<UserState>(context, listen: false).username;
      if (uname != null) return;
    }

    final query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    if (query.exists) {
      final data = query.data();
      if (data != null && data['username'] != null) {
        if (context.mounted) {
          Provider.of<UserState>(context, listen: false).setUsername(data['username']);
        }
        await prefs.setBool('isLoggedIn', true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          _syncUserData(context, snapshot.data!);
          return const HomePage();
        } else {
          return const FirstPage();
        }
      },
    );
  }
}
