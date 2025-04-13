import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/sizedbox.dart';
import '../text/customText.dart';

class CustomButton extends StatelessWidget {
  final String btnTitle;
  final Color btnTitleColor;
  final Color btnBorderColor;
  final Color bgColor;
  final Color iconColor;
  final bool haveBgColor;
  final bool useGradient;
  final double iconSize;
  final IconData icon;
  final Gradient? gradient;
  final double borderRadius;

  CustomButton({
    required this.haveBgColor,
    required this.btnTitle,
    required this.btnTitleColor,
    required this.btnBorderColor,
    required this.bgColor,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
    this.gradient,
    this.useGradient = true,
    required this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: haveBgColor ? bgColor : null,
        gradient: useGradient && gradient != null ? gradient : null,
        border: Border.all(
          color: btnBorderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            space10w,
            CustomText(
              textColor: btnTitleColor,
              fontSize: 14.sp,
              title: btnTitle,
              maxline: 1,
              text0verFlow: TextOverflow.ellipsis,
              fontWeight: FontWeight.w500,
              textStyle: GoogleFonts.montserrat,
            ),
            space10w,
            Icon(
              icon,
              color: iconColor,
              size: iconSize,
            ),
          ],
        ),
      ),
    );
  }
}
