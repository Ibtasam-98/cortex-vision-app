import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/colors.dart';
import '../../config/sizedbox.dart';
import '../widgets/customText.dart';



class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;

  const OnboardingPage({
    Key? key,
    required this.title,
    required this.description
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left:15.w,right: 15.w, top: 35.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          space25h,
          CustomText(
            textColor: whiteColor,
            fontSize: 22.sp,
            title: title,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            fontWeight: FontWeight.w600,
            textStyle: GoogleFonts.montserrat(),
          ),
          space5h,
          CustomText(
            textColor: whiteColor,
            fontSize: 16.sp,
            title: description,
            maxLines: 10,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ],
      ),
    );
  }
}