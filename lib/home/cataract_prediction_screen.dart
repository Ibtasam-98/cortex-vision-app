import 'dart:convert';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:intl/intl.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:uuid/uuid.dart';

import '../../../widgets/buttons/customAnimatedButton.dart';
import '../../../widgets/buttons/customButton.dart';
import '../../../widgets/customDrawer.dart';
import '../../../widgets/text/customText.dart';
import '../../../widgets/text/dualToneText.dart';
import '../config/colors.dart';
import '../config/sizedbox.dart';


class CataractPredictionScreen extends StatefulWidget {


  @override
  _CataractPredictionScreenState createState() => _CataractPredictionScreenState();
}


class _CataractPredictionScreenState extends State<CataractPredictionScreen> {
  int _selectedIndex = 0;
  final _advancedDrawerController = AdvancedDrawerController();
  File? imageFile;
  double averageAccuracy = 0.0;
  Map<String, dynamic>? detectionResponseData;
  bool isDetecting = false;
  bool _isDetectionComplete = false;
  String detectionResult = '';
  String downloadUrl = '';
  ButtonState _buttonState = ButtonState.idle;
  final user = FirebaseAuth.instance.currentUser;
  final userId = FirebaseAuth.instance.currentUser?.uid.toString() ?? "";




  String getNameFromEmail(String email) {
    List<String> parts = email.split('@');
    String name = parts.first;
    return name;
  }

  String formattedDate = DateFormat('yyyy-MM-dd').format(Timestamp.now().toDate());
  String formattedTime = DateFormat('HH:mm:ss').format(Timestamp.now().toDate());


  @override
  Widget build(BuildContext context) {
    String userName = getNameFromEmail(user!.email.toString());


    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: DualToneText(
          firstText: 'Cortex',
          firstTextColor: primaryColor,
          firstTextStyle: GoogleFonts.montserrat,
          secondText: ' Vision',
          secondTextColor: blackColor,
          secondTextStyle: GoogleFonts.montserrat,
          firstTextFontWeight: FontWeight.w400,
          secondTextFontWeight: FontWeight.bold,
          firstTextFontSize: 20.sp,
          secondTextFontSize: 20.sp,
        ),
        leading: IconButton(
          onPressed:(){Get.back();},
          icon: Icon(Icons.arrow_back_ios,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              space10h,
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    gradient: LinearGradient(colors: [primaryColor, secondryColor]),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.w),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              space10h,
                              Container(
                                width: 190.w,
                                child: CustomText(
                                  text0verFlow: TextOverflow.ellipsis,
                                  maxline: 4,
                                  fontSize: 14.sp,
                                  textColor: whiteColor,
                                  title: "Detecting cataracts early offers the advantage of timely intervention",
                                  fontWeight: FontWeight.normal,
                                  textStyle: GoogleFonts.montserrat,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              SizedBox(height: 15.h),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: whiteColor,
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.h),
                                  child: CustomText(
                                    text0verFlow: TextOverflow.ellipsis,
                                    maxline: 1,
                                    fontSize: 12.sp,
                                    textColor: primaryColor,
                                    title: "Learn More",
                                    fontWeight: FontWeight.w700,
                                    textStyle: GoogleFonts.montserrat,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                          Image(
                            height: 110.h,
                            image: AssetImage("assets/headerbg2.png"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              space10h,
              imageFile == null
                  ? SizedBox()
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    textColor: blackColor,
                    fontSize: 18.sp,
                    textStyle: GoogleFonts.quicksand,
                    title: "Uploaded Image",
                    maxline: 2,
                    fontWeight: FontWeight.w500,
                    text0verFlow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: DottedBorder(
                      color: primaryColor,
                      strokeCap: StrokeCap.butt,
                      strokeWidth: 1,
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Image.file(
                          imageFile!,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h),
                  isDetecting
                      ? Center(
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      child:  LoadingIndicator(
                        indicatorType: Indicator.lineScalePulseOutRapid,
                        colors: const [primaryColor, Colors.orange, googleColor, yellowColor],
                        strokeWidth: 1,
                      ),
                    ),
                  )
                      : _isDetectionComplete
                      ? Center(
                    child: Column(
                      children: [
                        CustomText(
                          textColor: primaryColor,
                          fontSize: 16.sp,
                          title: 'Status: $detectionResult',
                          maxline: 2,
                          text0verFlow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          textStyle: GoogleFonts.quicksand,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 10.h),
                        CustomText(
                          textColor: primaryColor,
                          fontSize: 16.sp,
                          title: 'Average Accuracy: ${convertToPercentage(averageAccuracy.toString())}',
                          maxline: 2,
                          text0verFlow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          textStyle: GoogleFonts.quicksand,
                          fontWeight: FontWeight.w500,
                        ),


                        space15h,


                        RemoveImageButton(
                          state: _buttonState,
                          onPressed: _onButtonPressed,
                        ),
                        space10h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            space5w,
                            Expanded(
                              child: InkWell(
                                onTap: (){
                                  AwesomeDialog(
                                    context: context,
                                    animType: AnimType.scale,
                                    dialogType: DialogType.info,
                                    dismissOnBackKeyPress: false,
                                    dismissOnTouchOutside: false,
                                    btnCancelOnPress: () {
                                      print(formattedDate);
                                      print(formattedTime);
                                    },
                                    btnOkOnPress: () async {

                                      uploadImageToStorage(imageFile!, userId);
                                      if (imageFile != null) {
                                        String downloadUrl = await uploadImageToStorage(imageFile!, userId);
                                        if (downloadUrl.isNotEmpty) {
                                          saveDetectionResults(
                                            userId,
                                            detectionResult,
                                            convertToPercentage(averageAccuracy.toString()),
                                          );
                                          print(userId);
                                          print(downloadUrl);
                                          print(detectionResult);
                                          print(convertToPercentage(averageAccuracy.toString()));
                                        } else {
                                          print('Error: Image upload failed');
                                        }
                                      } else {
                                        print('Error: No image selected');
                                      }
                                    },
                                    btnCancelText: "Back",
                                    btnOkText: "Save",
                                    title: 'Confirm Data Submission',
                                    buttonsTextStyle: GoogleFonts.quicksand(fontSize:15.sp, color:whiteColor, fontWeight:FontWeight.w500),
                                    desc: 'By clicking Save, you agree to submit your image and detection results to our database.',
                                    titleTextStyle: GoogleFonts.montserrat(
                                      fontSize: 22.sp,
                                      fontWeight: FontWeight.bold,
                                      color: blackColor,
                                    ),
                                    descTextStyle: GoogleFonts.quicksand(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: blackColor,
                                    ),
                                  ).show();


                                },
                                child: CustomButton(
                                  haveBgColor: true,
                                  btnTitle: 'Save',
                                  btnBorderColor: primaryColor,
                                  btnTitleColor: whiteColor,
                                  bgColor: primaryColor,
                                  icon: Icons.save,
                                  iconColor: Colors.white,
                                  iconSize: 18.sp,
                                  borderRadius: 70,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                      : Column(
                    children: [
                      InkWell(
                          onTap:_startDetection,
                          child: CustomButton(
                            haveBgColor: false,
                            borderRadius: 80,
                            btnTitle: 'Start Detection',
                            btnTitleColor: whiteColor,
                            btnBorderColor: transparent,
                            bgColor: transparent,
                            icon: Icons.document_scanner,
                            iconColor: whiteColor,
                            iconSize: 15.h,
                            useGradient: true,
                            gradient: const LinearGradient(
                              colors: [primaryColor, tertaryColor],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          )
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: (){_imageFromGallery();},
        child: Icon(
          FontAwesomeIcons.camera,
          color: whiteColor,
          size: 16.h,
        ),


      ),
    );
  }

  void _imageFromGallery() async {
    PickedFile? pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery, maxHeight: 200, maxWidth: 200);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        detectionResult = '';
        averageAccuracy = 0.0;
        _isDetectionComplete = false;
      });
    }
  }
  Future<String> uploadImageToStorage(File imageFile, String userId) async {
    String imageUuid = Uuid().v4();
    String fileName = 'detection_image_$imageUuid.jpg';
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child('eyeImages').child(userId).child(fileName);


    try {
      // Upload image to Firebase Storage
      await ref.putFile(imageFile);


      // Get download URL after successful upload
      downloadUrl = await ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading image: $e');
      return ''; // Return empty string if upload fails
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
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Successfully',
          message: 'Data have been successfully saved!',
          contentType: ContentType.success,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } catch (e) {
      print('Error saving detection results: $e');
    }
  }


  void _startDetection() async {
    setState(() {
      isDetecting = true;
      detectionResult = '';
      averageAccuracy = 0.0;
    });


    if (imageFile == null) {
      setState(() {
        isDetecting = false;
        detectionResult = 'Please select an image first';
      });
      return;
    }


    final uri = Uri.parse('http://127.0.0.1:5000/predict'); // Changed endpoint to /predict
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', imageFile!.path));


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
              detectionResult = data['detection']; // Using the result from one of the models as the main result
            }
          });

          if (validAccuracyCount > 0) {
            averageAccuracy = totalAccuracy / validAccuracyCount;
          }

          setState(() {
            isDetecting = false;
            _isDetectionComplete = true;
          });

          // Show Snackbar based on detection result
          final snackBar = SnackBar(
            elevation: 0,
            behavior: SnackBarBehavior.fixed,
            backgroundColor: Colors.transparent,
            content: AwesomeSnackbarContent(
              title: 'Diagnostic Result',
              message: detectionResult == 'Cataract' // Assuming your Python API returns 'Cataract' or 'Normal'
                  ? 'Cataract detected! Please consult a healthcare professional.'
                  : 'No cataract detected. Continue regular eye checkups.',
              contentType: detectionResult == 'Cataract' ? ContentType.warning : ContentType.success,
            ),
          );
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        } else {
          setState(() {
            isDetecting = false;
            detectionResult = 'Error: Invalid response format';
          });
        }
        print(response.body);
      } else {
        setState(() {
          isDetecting = false;
          detectionResult = 'Error: ${detectionResponseData?['error'] ?? 'Something went wrong'}';
        });
      }
    } catch (e) {
      setState(() {
        isDetecting = false;
        detectionResult = 'Error: $e';
      });
    }
  }


  void _onButtonPressed() async {
    setState(() {
      _buttonState = ButtonState.loading;
    });
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _buttonState = ButtonState.success;
    });
    await Future.delayed(Duration(seconds: 2));


    setState(() {
      // Reset button state and remove uploaded image
      _buttonState = ButtonState.idle;
      imageFile = null;
      detectionResult = '';
      averageAccuracy = 0.0;
      _isDetectionComplete = false;
    });
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





