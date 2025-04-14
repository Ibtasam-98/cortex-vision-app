import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../authentications/loginScreen.dart';

class UserHomeController extends GetxController {
  final User? user; // Made user optional

  UserHomeController({this.user}); // Changed to optional parameter

  void logout() {
    FirebaseAuth.instance.signOut().then((_) {
      Get.offAll(LoginScreen()); // Use Get.offAll to clear the navigation stack
    }).catchError((error) {
      print('Error logging out: $error');
    });
  }
}