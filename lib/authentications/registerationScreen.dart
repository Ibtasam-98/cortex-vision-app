import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/colors.dart';
import '../../config/sizedbox.dart';
import '../../controllers/user/userRegisterationController.dart';
import '../widgets/buttons/customBackButton.dart';
import '../widgets/buttons/customButton.dart';
import '../widgets/text/customText.dart';
import '../widgets/text/dualToneText.dart';
import '../widgets/textfields/customTextFields.dart';
import 'loginScreen.dart';

class RegistrationScreen extends StatelessWidget {
  final RegistrationController _controller = Get.put(RegistrationController());

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
            child: Obx(
                  () => _buildRegistrationForm(),
            ),
          ),
          Positioned(
            bottom: 80.0,
            left: 10,
            right: 10,
            child: InkWell(
              onTap: () {
                Get.to(LoginScreen());
              },
              child: DualToneText(
                firstText: "Already have an Account? ",
                secondText: "Login here",
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
      ),
    );
  }

  Widget _buildRegistrationForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          space15h,
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
            fontSize: 17.sp,
            title: "Registration",
            maxline: 2,
            text0verFlow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          space5h,
          CustomText(
            textColor: blackColor,
            fontSize: 14.sp,
            title: "Welcome Please enter your information to create an account",
            maxline: 2,
            text0verFlow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            textStyle: GoogleFonts.montserrat,
          ),
          space10h,
          CustomTextField(
            label: 'Username',
            isPassword: false,
            icon: Icons.person,
            textEditingController: _controller.usernameController,
            validator: _controller.validateUsername,
            onSaved: _controller.saveUsername,
            placeholder: 'Enter your Username',
          ),
          CustomTextField(
            label: 'Email',
            isPassword: false,
            icon: Icons.email,
            textEditingController: _controller.emailController,
            validator: _controller.validateEmail,
            onSaved: _controller.saveEmail,
            placeholder: 'Enter your Email Address',
          ),
          CustomTextField(
            label: 'Password',
            isPassword: true,
            icon: Icons.lock,
            placeholder: 'Enter your Password',
            textEditingController: _controller.passwordController,
            validator: _controller.validatePassword,
            onSaved: _controller.savePassword,
          ),
          CustomTextField(
            label: 'Contact Number',
            isPassword: false,
            placeholder: 'Enter your Contact Number',
            icon: Icons.phone,
            textEditingController: _controller.contactNumberController,
            validator: _controller.validateContactNumber,
            onSaved: _controller.saveContactNumber,
          ),
          space10h,
          DropdownButtonFormField<String>(
            value: _controller.selectedGender.value,
            hint: CustomText(
              textColor: blackColor,
              fontSize: 15.sp,
              title: 'Select Gender',
              maxline: 1,
              text0verFlow: TextOverflow.ellipsis,
            ),
            items: _controller.genderList.where((value) => value != null).map((value) {
              return DropdownMenuItem<String>(
                value: value!,
                child: CustomText(
                  textColor: blackColor,
                  fontSize: 15.sp,
                  maxline: 1,
                  title: value,
                  text0verFlow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: (String? value) {
              _controller.selectGender(value);
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please select a gender';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.male),
              filled: true,
              fillColor: lightgray,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          space20h,
          Obx(() => _controller.isLoading.value
              ? Center(child: CircularProgressIndicator(color: blackColor))
              : InkWell(
            onTap: _controller.register,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: CustomButton(
                haveBgColor: false,
                btnTitle: 'Register',
                borderRadius: 80,
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
            ),
          )),
        ],
      ),
    );
  }
}
