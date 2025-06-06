import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizedbox.dart';
import '../controllers/user_registeration_controller.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';
import 'login_screen.dart';

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
              child: Center(
                child: CustomText(
                  firstText: "Already have an Account? ",
                  secondText: "Login here",
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

  Widget _buildRegistrationForm() {
    return Form(
      key: _controller.formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          space15h,
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
            fontSize: 17.sp,
            title: "Registration",
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          space5h,
          CustomText(
            textColor: blackColor,
            fontSize: 14.sp,
            title: "Welcome Please enter your information to create an account",
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
            textStyle: GoogleFonts.montserrat(),
          ),
          space10h,
          CustomTextField(
            label: 'Username',
            isPassword: false,
            icon: Icons.person,
            textEditingController: _controller.usernameController,
            validator: _controller.validateUsername,
            onSaved: _controller.saveUsername,
            placeholder: 'Username',
          ),
          CustomTextField(
            label: 'Email',
            isPassword: false,
            icon: Icons.email,
            textEditingController: _controller.emailController,
            validator: _controller.validateEmail,
            onSaved: _controller.saveEmail,
            placeholder: 'Email Address',
          ),
          CustomTextField(
            label: 'Password',
            isPassword: true,
            icon: Icons.lock,
            placeholder: 'Password',
            textEditingController: _controller.passwordController,
            validator: _controller.validatePassword,
            onSaved: _controller.savePassword,
          ),
          CustomTextField(
            label: 'Contact Number',
            isPassword: false,
            placeholder: 'Contact Number',
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
              maxLines: 1,
              textOverflow: TextOverflow.ellipsis,
            ),
            items: _controller.genderList.where((value) => value != null).map((value) {
              return DropdownMenuItem<String>(
                value: value!,
                child: CustomText(
                  textColor: blackColor,
                  fontSize: 15.sp,
                  maxLines: 1,
                  title: value,
                  textOverflow: TextOverflow.ellipsis,
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
