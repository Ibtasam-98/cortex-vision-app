import 'package:cortex_vision_app/home/cataract_prediction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'loginScreen.dart';


class AuthPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: _auth.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
              // Check if the user is an admin or a normal user
              return _checkUserRole(snapshot.data!);
            } else {
              return LoginScreen();
            }
          }
        },
      ),
    );
  }

  Widget _checkUserRole(User user) {
    print('User email: ${user.email}');
    if (_isAdmin(user)) {
      print('User is admin');
      return Placeholder();
    } else {
      print('User is not admin'); // Add debug output
      return CataractPredictionScreen();
    }
  }

  bool _isAdmin(User user) {
    return user.email == 'admin@gmail.com';
  }
}
