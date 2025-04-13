import 'package:cortex_vision_app/authentications/registerationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/colors.dart';
import '../../config/sizedbox.dart';
import '../../controllers/user/userLoginController.dart';
import '../widgets/buttons/customBackButton.dart';
import '../widgets/buttons/customButton.dart';
import '../widgets/text/customText.dart';
import '../widgets/text/dualToneText.dart';
import '../widgets/textfields/customTextFields.dart';
import 'forgotPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final LoginController _controller = Get.put(LoginController());

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
                  DualToneText(
                    firstText: "Cortex",
                    secondText: " Vision",
                    firstTextStyle: GoogleFonts.montserrat,
                    secondTextStyle: GoogleFonts.montserrat,
                    firstTextColor: primaryColor,
                    secondTextColor: blackColor,
                    firstTextFontWeight: FontWeight.bold,
                    secondTextFontWeight: FontWeight.w500,
                    firstTextFontSize: 22.sp,
                    secondTextFontSize: 22.sp,
                  ),
                  CustomText(
                    textColor: blackColor,
                    fontSize: 21.sp,
                    title: "Login",
                    maxline: 2,
                    text0verFlow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  space10h,
                  CustomText(
                    textColor: blackColor,
                    fontSize: 15.sp,
                    title: "Welcome Back Please enter your credentials to login",
                    maxline: 2,
                    text0verFlow: TextOverflow.ellipsis,
                    textAlign: TextAlign.start,
                  ),
                  space15h,
                  CustomTextField(
                    label: 'Email',
                    isPassword: false,
                    icon: Icons.email,
                    placeholder: 'Enter your Email Address',
                    textEditingController: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty || !RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  CustomTextField(
                    label: 'Password',
                    isPassword: true,
                    icon: Icons.lock,
                    placeholder: 'Enter your Password',
                    textEditingController: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                  space5h,
                  InkWell(
                    onTap: (){
                    //  Get.to(ForgotPasswordScreen());
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomText(
                        textColor: primaryColor,
                        fontSize: 14.sp,
                        title: "Forgot Password ?",
                        maxline: 2,
                        text0verFlow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        fontWeight: FontWeight.w500,
                        textStyle:GoogleFonts.montserrat,
                      ),
                    ),
                  ),
                  space20h,
                  InkWell(
                    onTap: () {
                      _controller.login(
                        emailController.text,
                        passwordController.text,
                      );
                    },
                    child: Obx(() {
                      return _controller.isLoading.value
                          ? const Center(child: CircularProgressIndicator())
                          : CustomButton(
                        haveBgColor: false,
                        borderRadius: 80,
                        btnTitle: 'Login',
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
                      );}

                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 80.0,
            left: 10,
            right: 10,
            child: InkWell(
              onTap: (){
                Get.to(RegistrationScreen());
              },
              child: DualToneText(
                firstText: "Don't have an Account ? ",
                secondText: "Register here",
                firstTextStyle: GoogleFonts.montserrat,
                secondTextStyle: GoogleFonts.montserrat,
                firstTextColor: blackColor,
                secondTextColor: primaryColor,
                firstTextFontWeight: FontWeight.w500,
                secondTextFontWeight: FontWeight.bold,
                firstTextFontSize: 15.sp,
                secondTextFontSize: 15.sp,
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 15,
            right: 10,
            child: CustomBackButton(),
          ),
        ],
      )
    );
  }
}
