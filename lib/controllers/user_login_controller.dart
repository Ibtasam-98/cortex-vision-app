import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../authentications/registeration_screen.dart';
import '../home/cataract_prediction_screen.dart'; // Assuming this is your home screen

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final isLoading = false.obs;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !value.contains('@')) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    return null;
  }

  Future<void> login(String email, String password) async {
    if (validateEmail(email) != null || validatePassword(password) != null) {
      return;
    }

    try {
      isLoading.value = true;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.offAll(() => CataractPredictionScreen());
    } catch (e) {
      isLoading.value = false;
      String errorMessage = "Login failed. Please check your credentials.";
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          errorMessage = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          errorMessage = 'Wrong password provided for that user.';
        }
      }
      Get.snackbar(
        'Login Error',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToRegistration() {
    Get.to(() => RegistrationScreen());
  }

  void goToForgotPassword() {
    // Get.to(() => ForgotPasswordScreen());
    print("Forgot Password clicked");
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}