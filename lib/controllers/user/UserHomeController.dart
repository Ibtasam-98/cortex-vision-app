import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../authentications/loginScreen.dart';

class UserHomeController extends GetxController {
  final User user;

  UserHomeController({required this.user});

  void logout() {
    FirebaseAuth.instance.signOut().then((_) {
      Get.offAll(LoginScreen()); // Use Get.offAll to clear the navigation stack
    }).catchError((error) {
      print('Error logging out: $error');
    });
  }
}


