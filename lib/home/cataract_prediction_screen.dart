import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../widgets/custom_animated_button.dart';
import '../widgets/custom_button.dart';
import '../controllers/user_home_controller.dart';
import '../controllers/cataract_prediction_controller.dart';
import '../widgets/custom_text.dart';
import '../config/app_colors.dart';
import '../config/app_sizedbox.dart';

class CataractPredictionScreen extends StatelessWidget {
  final UserHomeController userHomeController = Get.find<UserHomeController>();
  final CataractPredictionController controller = Get.put(CataractPredictionController());
  final user = FirebaseAuth.instance.currentUser;

  String getNameFromEmail(String email) {
    List<String> parts = email.split('@');
    String name = parts.first;
    return name;
  }

  @override
  Widget build(BuildContext context) {
    String userName = getNameFromEmail(user!.email.toString());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        title: CustomText(
          firstText: 'Cortex',
          firstTextColor: primaryColor,
          secondText: ' Vision',
          secondTextColor: blackColor,
          firstTextFontWeight: FontWeight.w400,
          secondTextFontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.west),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.w),
            child: InkWell(
              onTap: () {
                userHomeController.logout();
              },
              child: Icon(
                Icons.logout,
                color: red,
                size: 18.sp,
              ),
            ),
          )
        ],
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
                                  textOverflow: TextOverflow.ellipsis,
                                  maxLines: 4,
                                  fontSize: 14.sp,
                                  textColor: whiteColor,
                                  title: "Detecting cataracts early offers the advantage of timely intervention",
                                  fontWeight: FontWeight.normal,
                                  textStyle: GoogleFonts.montserrat(),
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
                                    textOverflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    fontSize: 12.sp,
                                    textColor: primaryColor,
                                    title: "Learn More",
                                    fontWeight: FontWeight.w700,
                                    textStyle: GoogleFonts.montserrat(),
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
              Obx(
                    () => controller.imageFile.value == null
                    ? SizedBox()
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      textColor: blackColor,
                      fontSize: 18.sp,
                      textStyle: GoogleFonts.quicksand(),
                      title: "Uploaded Image",
                      maxLines: 2,
                      fontWeight: FontWeight.w500,
                      textOverflow: TextOverflow.ellipsis,
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
                            controller.imageFile.value!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    Obx(
                          () => controller.isDetecting.value
                          ? Center(
                        child: Container(
                          height: 60.h,
                          width: 60.w,
                          child: LoadingIndicator(
                            indicatorType: Indicator.lineScalePulseOutRapid,
                            colors: const [
                              primaryColor,
                              Colors.orange,
                              googleColor,
                              yellowColor
                            ],
                            strokeWidth: 1,
                          ),
                        ),
                      )
                          : Obx(
                            () => controller.isDetectionComplete.value
                            ? Center(
                          child: Column(
                            children: [
                              CustomText(
                                textColor: primaryColor,
                                fontSize: 16.sp,
                                title: 'Status: ${controller.detectionResult.value}',
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                textStyle: GoogleFonts.quicksand(),
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 10.h),
                              CustomText(
                                textColor: primaryColor,
                                fontSize: 16.sp,
                                title:
                                'Average Accuracy: ${controller.convertToPercentage(controller.averageAccuracy.value.toString())}',
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                textStyle: GoogleFonts.quicksand(),
                                fontWeight: FontWeight.w500,
                              ),
                              space15h,
                              Obx(
                                    () => CustomAnimatedButton(
                                  state: controller.buttonState.value,
                                  onPressed: controller.onButtonPressed,
                                ),
                              ),
                              space10h,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  space5w,
                                  Expanded(
                                    child: InkWell(
                                      onTap: () {
                                        AwesomeDialog(
                                          context: context,
                                          animType: AnimType.scale,
                                          dialogType: DialogType.info,
                                          dismissOnBackKeyPress: false,
                                          dismissOnTouchOutside: false,
                                          btnCancelOnPress: () {
                                            print(controller.formattedDate);
                                            print(controller.formattedTime);
                                          },
                                          btnOkOnPress: () async {
                                            if (controller.imageFile.value != null) {
                                              String downloadUrl = await controller
                                                  .uploadImageToStorage(
                                                  controller.imageFile.value!,
                                                  controller.userId);
                                              if (downloadUrl.isNotEmpty) {
                                                controller.saveDetectionResults(
                                                  controller.userId,
                                                  controller.detectionResult.value,
                                                  controller.convertToPercentage(
                                                      controller.averageAccuracy.value.toString()),
                                                );
                                                print(controller.userId);
                                                print(downloadUrl);
                                                print(controller.detectionResult.value);
                                                print(controller.convertToPercentage(
                                                    controller.averageAccuracy.value.toString()));
                                              } else{
                                                print('Error: Image upload failed');
                                              }
                                            } else {
                                              print('Error: No image selected');
                                            }
                                          },
                                          btnCancelText: "Back",
                                          btnOkText: "Save",
                                          title: 'Confirm Data Submission',
                                          buttonsTextStyle: GoogleFonts.quicksand(
                                              fontSize: 15.sp,
                                              color: whiteColor,
                                              fontWeight: FontWeight.w500),
                                          desc:
                                          'By clicking Save, you agree to submit your image and detection results to our database.',
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
                                onTap: controller.startDetection,
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
                                )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: controller.imageFromGallery,
        child: Icon(
          FontAwesomeIcons.camera,
          color: whiteColor,
          size: 16.h,
        ),
      ),
    );
  }
}