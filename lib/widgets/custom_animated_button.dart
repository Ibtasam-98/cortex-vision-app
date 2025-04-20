import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';

class CustomAnimatedButton extends StatelessWidget {
  final ButtonState state;
  final VoidCallback onPressed;

  const CustomAnimatedButton({
    required this.state,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width - 30,
      child: ProgressButton.icon(
        textStyle: GoogleFonts.montserrat(color: whiteColor, fontSize: 15.sp),
        iconedButtons: {
          ButtonState.idle: const IconedButton(
            text: "Remove Image",
            icon: Icon(Icons.highlight_remove, color: whiteColor, size: 25),
            color: redDarkShade,
          ),
          ButtonState.loading: const IconedButton(
            text: "Loading",
            color: primaryColor,
          ),
          ButtonState.fail: IconedButton(
            text: "Failed",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300,
          ),
          ButtonState.success: IconedButton(
            text: "Removed",
            icon: Icon(Icons.check_circle, color: whiteColor, size: 25),
            color: greenColor,
          ),
        },
        onPressed: onPressed,
        state: state,
      ),
    );
  }
}