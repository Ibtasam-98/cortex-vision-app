import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/colors.dart';
import '../../../config/sizedbox.dart';
import '../../authentications/loginScreen.dart';
import '../../authentications/welcomeScreen.dart';
import '../text/customText.dart';


class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.offAll(WelcomeScreen());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.west, color: blackColor, size: 20.w,),
            ),
            space8w,
            CustomText(
              textColor: blackColor,
              fontSize: 17.sp,
              title: "Back",
              maxline: 2,
              text0verFlow: TextOverflow.ellipsis,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w400,
              textStyle: GoogleFonts.montserrat,
            ),

          ],
        ),
      ),
    );
  }
}
