import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizedbox.dart';
import '../controllers/welcome_screen_controller.dart';
import '../home/cataract_prediction_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import 'authentication.dart';
import 'onboarding.dart';

class WelcomeScreen extends StatelessWidget {
  final WelcomeController welcomeController = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            // Background Image
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/welcomeScreen_bg.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // Black Shadow
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    blackColor.withOpacity(0.90),
                    blackColor.withOpacity(0.4),
                  ],
                ),
              ),
            ),
            // Your Scaffold Content
            Scaffold(
              backgroundColor: transparent,
              body: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                        title: "27\nSupport",
                        textColor: whiteColor.withOpacity(0.6),
                        fontSize: 14.sp,
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                        title: "104\nHappy\nPatients",
                        textColor: whiteColor.withOpacity(0.6),
                        fontSize: 14.sp,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200.h,
                          child: PageView(
                            controller: welcomeController.pageController,
                            onPageChanged: (int page) {
                              welcomeController.currentPage.value = page;
                            },
                            children: [
                              OnboardingPage(
                                title: 'Cataract Detection',
                                description:
                                'Explore the future of eye care with our cutting-edge AI technology, designed to safeguard your vision',
                              ),
                              OnboardingPage(
                                title: 'Early Detection',
                                description:
                                'Detect cataracts early for clearer vision and proactive eye health management, ensuring optimal clarity and comfort',
                              ),
                              OnboardingPage(
                                title: 'Eye Wellness',
                                description:
                                'Experience personalized eye wellness solutions tailored to your unique needs, backed by state-of-the-art artificial intelligence for comprehensive care.',
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(
                              3,
                                  (index) => buildIndicator(index),
                            ),
                          )),
                        )
                      ],
                    ),
                    space35h,
                    InkWell(
                      onTap: () {
                        Get.to(AuthPage());
                      },
                      child: CustomButton(
                        haveBgColor: false,
                        btnTitle: 'Get Started',
                        borderRadius: 80,
                        btnTitleColor: whiteColor,
                        btnBorderColor: whiteColor,
                        bgColor: transparent,
                        icon: FontAwesomeIcons.arrowRight,
                        iconColor: whiteColor,
                        iconSize: 16.h,
                        useGradient: false,
                      ),
                    ),
                    space55h,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildIndicator(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      height: 8.h,
      width: (welcomeController.currentPage.value == index) ? 30 : 10,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (welcomeController.currentPage.value == index) ? secondryColor : whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}
