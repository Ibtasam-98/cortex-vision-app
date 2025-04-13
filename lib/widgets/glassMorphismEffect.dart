import 'package:cortex_vision_app/widgets/text/customText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

import '../config/colors.dart';

class GlassMorphism extends StatelessWidget {
  GlassMorphism({
    required this.heading,
    required this.subHeading,
    required this.headingColor,
    required this.subHeadingColor,
    required this.headingFontSize,
    required this.subHeadingFontSize,
  });
  final heading, subHeading, headingFontSize, subHeadingFontSize;
  Color headingColor, subHeadingColor;

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      blur: 3,
      color: Colors.black.withOpacity(0.2),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          whiteColor.withOpacity(0.2),
          blackColor.withOpacity(0.1),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(left:30.w, right: 30.w, top: 12.h, bottom: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomText(
              textColor: headingColor,
              fontSize: headingFontSize,
              title: heading,
              maxline: 2,
              text0verFlow: TextOverflow.ellipsis,
            ),
            CustomText(
              textColor: subHeadingColor,
              fontSize: subHeadingFontSize,
              title: subHeading,
              maxline: 2,
              text0verFlow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
