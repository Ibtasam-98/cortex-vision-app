import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../authentications/loginScreen.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final contactNumberController = TextEditingController();
  final RxString selectedGender = ''.obs;
  final RxBool isLoading = false.obs;

  List<String?> genderList = ['Male', 'Female'];

  @override
  void onInit() {
    super.onInit();
    selectedGender.value = genderList.first!;
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      return 'Please enter a valid username';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty || value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? validateContactNumber(String? value) {
    if (value == null || value.isEmpty || !RegExp(r'^\d+$').hasMatch(value)) {
      return 'Please enter a valid contact number';
    }
    return null;
  }

  String? validateGender(String? value) {
    if (value == null) {
      return 'Please select a gender';
    }
    return null;
  }

  void saveUsername(String? value) {}
  void saveEmail(String? value) {}
  void savePassword(String? value) {}
  void saveContactNumber(String? value) {}

  void selectGender(String? value) {
    selectedGender.value = value!;
  }

  void register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      isLoading.value = true;
      try {
        final newUser = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        await FirebaseFirestore.instance.collection('users').doc(newUser.user!.uid).set({
          'username': usernameController.text,
          'email': emailController.text,
          'contactNumber': contactNumberController.text,
          'gender': selectedGender.value,
        });

        Get.snackbar(
          'Success',
          'Registration Successful',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );

        Get.offAll(LoginScreen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          Get.snackbar(
            'Alert',
            'Email already exists',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        } else {
          Get.snackbar(
            'Alert',
            'Registration Failed: ${e.message}',
            backgroundColor: Colors.red,
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } catch (e) {
        Get.snackbar(
          'Alert',
          'An unexpected error occurred: $e',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    contactNumberController.dispose();
    super.dispose();
  }
}
