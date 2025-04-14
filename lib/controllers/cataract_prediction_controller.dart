import 'dart:convert';
import 'dart:io';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

class CataractPredictionController extends GetxController {
  Rx<File?> imageFile = Rx<File?>(null);
  RxDouble averageAccuracy = 0.0.obs;
  Map<String, dynamic>? detectionResponseData;
  RxBool isDetecting = false.obs;
  RxBool isDetectionComplete = false.obs;
  RxString detectionResult = ''.obs;
  String downloadUrl = '';
  Rx<ButtonState> buttonState = ButtonState.idle.obs;
  final user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid.toString() ?? "";

  String formattedDate = DateFormat('yyyy-MM-dd').format(Timestamp.now().toDate());
  String formattedTime = DateFormat('HH:mm:ss').format(Timestamp.now().toDate());

  String getNameFromEmail(String email) {
    List<String> parts = email.split('@');
    String name = parts.first;
    return name;
  }

  Future<void> imageFromGallery() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      detectionResult.value = '';
      averageAccuracy.value = 0.0;
      isDetectionComplete.value = false;
    }
  }

  Future<String> uploadImageToStorage(File imageFile, String userId) async {
    String imageUuid = Uuid().v4();
    String fileName = 'detection_image_$imageUuid.jpg';
    firebase_storage.Reference ref =
    firebase_storage.FirebaseStorage.instance.ref().child('eyeImages').child(userId).child(fileName);

    try {
      await ref.putFile(imageFile);
      downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  Future<void> saveDetectionResults(String userId, String detectionResult, String accuracy) async {
    try {
      await FirebaseFirestore.instance.collection('detectionResults').add({
        'userId': userId,
        'imageURL': downloadUrl,
        'detectionResult': detectionResult,
        'averageAccuracyResult': accuracy,
        'uploadDate': formattedDate,
        'uploadTime': formattedTime,
      });
      final snackBar = GetSnackBar(
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.transparent,
        messageText: AwesomeSnackbarContent(
          title: 'Successfully',
          message: 'Data have been successfully saved!',
          contentType: ContentType.success,
        ),
        duration: Duration(seconds: 3), // Optional duration
      );
      Get.showSnackbar(snackBar);
    } catch (e) {
      print('Error saving detection results: $e');
    }
  }

  Future<void> startDetection() async {
    isDetecting.value = true;
    detectionResult.value = '';
    averageAccuracy.value = 0.0;

    if (imageFile.value == null) {
      isDetecting.value = false;
      detectionResult.value = 'Please select an image first';
      return;
    }

    final uri = Uri.parse('http://127.0.0.1:5000/predict');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.value!.path));

    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      detectionResponseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        double totalAccuracy = 0;
        int validAccuracyCount = 0;

        if (detectionResponseData != null) {
          detectionResponseData!.forEach((modelName, data) {
            if (data != null && data.containsKey('accuracy')) {
              try {
                String accuracyStr = data['accuracy'].toString().replaceAll('%', '');
                double accuracy = double.parse(accuracyStr);
                totalAccuracy += accuracy;
                validAccuracyCount++;
              } catch (e) {
                print('Error parsing accuracy for $modelName: $e');
              }
            }
            if (modelName == 'Default Linear SVM' && data != null && data.containsKey('detection')) {
              detectionResult.value = data['detection'];
            }
          });

          if (validAccuracyCount > 0) {
            averageAccuracy.value = totalAccuracy / validAccuracyCount;
          }

          isDetecting.value = false;
          isDetectionComplete.value = true;

          final snackBar = GetSnackBar(
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.transparent,
            messageText: AwesomeSnackbarContent(
              title: 'Diagnostic Result',
              message: detectionResult.value == 'Cataract'
                  ? 'Cataract detected! Please consult a healthcare professional.'
                  : 'No cataract detected. Continue regular eye checkups.',
              contentType: detectionResult.value == 'Cataract' ? ContentType.warning : ContentType.success,
            ),
            duration: Duration(seconds: 3),
          );
          Get.showSnackbar(snackBar);
        } else {
          isDetecting.value = false;
          detectionResult.value = 'Error: Invalid response format';
        }
        print(response.body);
      } else {
        isDetecting.value = false;
        detectionResult.value = 'Error: ${detectionResponseData?['error'] ?? 'Something went wrong'}';
      }
    } catch (e) {
      isDetecting.value = false;
      detectionResult.value = 'Error: $e';
    }
  }

  Future<void> onButtonPressed() async {
    buttonState.value = ButtonState.loading;
    await Future.delayed(Duration(seconds: 2));
    buttonState.value = ButtonState.success;
    await Future.delayed(Duration(seconds: 2));

    // Reset button state and remove uploaded image
    buttonState.value = ButtonState.idle;
    imageFile.value = null;
    detectionResult.value = '';
    averageAccuracy.value = 0.0;
    isDetectionComplete.value = false;
  }

  String convertToPercentage(String accuracyString) {
    try {
      String cleanedAccuracyString = accuracyString.replaceAll(RegExp('[^0-9.]'), '');
      double accuracy = double.parse(cleanedAccuracyString);
      if (accuracy >= 0 && accuracy <= 100) {
        return '${accuracy.toStringAsFixed(2)}%';
      } else {
        return 'Invalid accuracy';
      }
    } catch (e) {
      return 'N/A';
    }
  }
}