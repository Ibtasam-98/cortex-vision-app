import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/app_colors.dart';
import '../../config/app_sizedbox.dart';
import '../authentications/welcome_screen.dart';
import 'custom_text.dart';

class CustomButton extends StatelessWidget {
  final String? btnTitle;
  final Color? btnTitleColor;
  final Color? btnBorderColor;
  final Color? bgColor;
  final Color? iconColor;
  final bool haveBgColor;
  final bool useGradient;
  final double? iconSize;
  final IconData? icon;
  final Gradient? gradient;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool isBackButton;

  const CustomButton({
    super.key,
    this.btnTitle,
    this.btnTitleColor,
    this.btnBorderColor = Colors.transparent,
    this.bgColor = Colors.transparent,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.gradient,
    this.useGradient = false,
    this.haveBgColor = false,
    this.borderRadius = 8.0,
    this.onTap,
    this.isBackButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap ??
          (isBackButton
              ? () {
            Get.offAll(WelcomeScreen());
          }
              : null),
      child: Container(
        width: Get.width- 30,
        decoration: BoxDecoration(
          color: haveBgColor ? bgColor : null,
          gradient: useGradient && gradient != null ? gradient : null,
          border: Border.all(
            color: btnBorderColor ?? Colors.transparent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isBackButton) ...[
              Icon(
                Icons.west,
                color: btnTitleColor ?? blackColor,
                size: 20.w,
              ),
              space8w,
            ],
            if (btnTitle != null)
              CustomText(
                textColor: btnTitleColor ?? blackColor,
                fontSize: isBackButton ? 17.sp : 14.sp,
                title: btnTitle!,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                textStyle: GoogleFonts.montserrat(),
              ),
            if (icon != null) ...[
              space10w,
              Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
            ],
          ],
        ),
      ),
    );
  }
}