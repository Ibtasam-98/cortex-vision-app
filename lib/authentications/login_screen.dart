import 'package:cortex_vision_app/authentications/registeration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizedbox.dart';
import '../controllers/user_login_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final LoginController _controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/auth_bg.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    firstText: "Cortex",
                    secondText: " Vision",
                    firstTextColor: primaryColor,
                    secondTextColor: blackColor,
                    firstTextFontWeight: FontWeight.bold,
                    secondTextFontWeight: FontWeight.w500,
                    fontSize: 22.sp,
                  ),
                  CustomText(
                    textColor: blackColor,
                    fontSize: 18.sp,
                    title: "Login",
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  space10h,
                  CustomText(
                    textColor: blackColor,
                    fontSize: 14.sp,
                    title: "Welcome Back Please enter your credentials to login",
                    maxLines: 2,
                    textOverflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  space15h,
                  CustomTextField(
                    label: 'Email',
                    isPassword: false,
                    icon: Icons.email,
                    placeholder: 'Email Address',
                    textEditingController: _controller.emailController,
                    validator: _controller.validateEmail,
                    onSaved: (value) {},
                  ),
                  CustomTextField(
                    label: 'Password',
                    isPassword: true,
                    icon: Icons.lock,
                    placeholder: 'Password',
                    textEditingController: _controller.passwordController,
                    validator: _controller.validatePassword,
                    onSaved: (value) {},
                  ),
                  space5h,
                  InkWell(
                    onTap: _controller.goToForgotPassword,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomText(
                        textColor: primaryColor,
                        fontSize: 12.sp,
                        title: "Forgot Password ?",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        textStyle: GoogleFonts.montserrat(),
                      ),
                    ),
                  ),
                  space20h,
                  Obx(() {
                    return InkWell(
                      onTap: _controller.isLoading.value
                          ? null // Disable button while loading
                          : () {
                        if (_formKey.currentState!.validate()) {
                          _controller.login(
                            _controller.emailController.text,
                            _controller.passwordController.text,
                          );
                        }
                      },
                      child: CustomButton(
                        haveBgColor: false,
                        borderRadius: 80,
                        btnTitle: _controller.isLoading.value ? 'Logging In...' : 'Login',
                        btnTitleColor: whiteColor,
                        btnBorderColor: transparent,
                        bgColor: transparent,
                        icon: Icons.check,
                        iconColor: whiteColor,
                        iconSize: 15.h,
                        useGradient: true,
                        gradient: const LinearGradient(
                          colors: [primaryColor, tertaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 80.0,
            left: 10,
            right: 10,
            child: InkWell(
              onTap: _controller.goToRegistration,
              child: Center(
                child: CustomText(
                  firstText: "Don't have an Account ? ",
                  secondText: "Register here",
                  firstTextColor: blackColor,
                  secondTextColor: primaryColor,
                  firstTextFontWeight: FontWeight.w500,
                  secondTextFontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

