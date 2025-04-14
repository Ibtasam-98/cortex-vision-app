// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class UserProfileController extends GetxController {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//   final FirebaseStorage _storage = FirebaseStorage.instance;
//   final ImagePicker _picker = ImagePicker();
//
//   var profilePictureUrl = ''.obs;
//   var username = ''.obs;
//   var gender = ''.obs;
//   var email = ''.obs;
//   var contactNumber = ''.obs;
//   var isLoading = false.obs;  // Changed to RxBool
//
//   @override
//   void onInit() {
//     super.onInit();
//     _fetchProfilePicture();
//   }
//
//   Future<void> _fetchProfilePicture() async {
//     try {
//       final userId = _auth.currentUser!.uid;
//       final userRef = _firestore.collection('users').doc(userId);
//       final userDoc = await userRef.get();
//
//       if (userDoc.exists) {
//         final userData = userDoc.data()!;
//         profilePictureUrl.value = userData['profilePictureUrl'] ?? '';
//         username.value = userData['username'] ?? '';
//         gender.value = userData['gender'] ?? '';
//         email.value = userData['email'] ?? '';
//         contactNumber.value = userData['contactNumber'] ?? '';
//       }
//     } catch (e) {
//       // Handle error
//     }
//   }
//
//   Future<void> uploadImage() async {
//     final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       isLoading.value = true;
//
//       try {
//         final user = _auth.currentUser;
//         if (user == null) {
//           throw Exception('User not authenticated');
//         }
//
//         final userId = user.uid;
//
//         final storageRef = _storage.ref().child('profile_images/$userId');
//         final uploadTask = storageRef.putFile(File(pickedFile.path));
//         final res = await uploadTask;
//         final downloadUrl = await res.ref.getDownloadURL();
//
//         final userRef = _firestore.collection('users').doc(userId);
//         await userRef.update({'profilePictureUrl': downloadUrl});
//
//         profilePictureUrl.value = downloadUrl;
//
//         _showSnackBar('Profile image added successfully!');
//       } catch (e) {
//         print('Error uploading image: $e');
//         _showSnackBar('Error uploading image. Please try again later.');
//       } finally {
//         isLoading.value = false;
//       }
//     }
//   }
//
//   Future<void> removeImage() async {
//     try {
//       final userId = _auth.currentUser!.uid;
//       final userRef = _firestore.collection('users').doc(userId);
//       await userRef.update({'profilePictureUrl': ''});
//
//       final storageRef = _storage.ref().child('profile_images/$userId');
//       await storageRef.delete();
//
//       profilePictureUrl.value = '';
//
//       _showSnackBar('Profile image removed successfully!');
//     } catch (e) {
//       // Handle error
//     }
//   }
//
//   void _showSnackBar(String message) {
//     Get.snackbar('Profile Image', message);
//   }
// }
