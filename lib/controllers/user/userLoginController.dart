import 'package:cortex_vision_app/home/cataract_prediction_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';


class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final RxBool isLoading = false.obs;

  Future<void> login(String email, String password) async {
    isLoading.value = true;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential != null) {
        final user = userCredential.user!;
        // Navigate based on user role
        if (isAdmin(user)) {
          // Navigate to admin dashboard
          //  Get.offAll(AdminDashboardScreen());
        } else {
          // Navigate to user home screen
           Get.offAll(CataractPredictionScreen());
        }
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Login Failed', e.message ?? 'An error occurred');
    } finally {
      isLoading.value = false;
    }
  }

  bool isAdmin(User user) {
    // Check if the user email matches the admin email
    return user.email == 'admin@gmail.com';
  }
}
