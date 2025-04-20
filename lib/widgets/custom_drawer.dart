import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cortex_vision_app/widgets/custom_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/app_colors.dart';
import '../../config/app_sizedbox.dart';
class CustomDrawer extends StatelessWidget {
  final bool isAdmin;

  const CustomDrawer({Key? key, required this.isAdmin}) : super(key: key);

  Future<DocumentSnapshot> _getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: ListTileTheme(
          textColor: Colors.white,
          iconColor: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              space35h,
              if (!isAdmin)
                FutureBuilder<DocumentSnapshot>(
                  future: _getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (!snapshot.hasData || snapshot.data!.data() == null) { // Check for null data
                      return Center(child: Text('User data not found'));
                    } else {
                      var userData = snapshot.data!.data()! as Map<String, dynamic>; // Use null assertion operator (!)
                      return Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Display profile picture if available, otherwise display default avatar
                            CircleAvatar(
                              radius: 42.r,
                              backgroundColor: whiteColor,
                              child: CircleAvatar(
                                radius: 40.r,
                                backgroundColor: primaryColor,
                                child: CircleAvatar(
                                  radius: 38.r,
                                  backgroundColor: whiteColor,
                                  backgroundImage: userData['profilePictureUrl'] != null
                                      ? NetworkImage(userData['profilePictureUrl'])
                                      : null,
                                  child: userData['profilePictureUrl'] != null
                                      ? null
                                      : userData['username'] != null
                                      ? Text(
                                    userData['username'][0].toUpperCase(), // Display first character of username
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: blackColor
                                    ),
                                  )
                                      : null, // Display nothing if username is null
                                ),
                              ),
                            ),

                            space10h,
                            CustomText(
                              textColor: whiteColor,
                              fontSize: 16.sp,
                              title: '${userData['username']?.toString().toUpperCase() ?? 'Username'}', // Use null-aware operator
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              textStyle: GoogleFonts.montserrat(),
                            ),
                            CustomText(
                              textColor: whiteColor,
                              fontSize: 13.sp,
                              title: '${userData['email'] ?? 'Email'}', // Use null-aware operator
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w600,
                              textStyle: GoogleFonts.montserrat(),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),

              if (isAdmin) // Only show role heading for admin
                Padding(
                  padding: EdgeInsets.only(left: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 35.r,
                        backgroundColor: whiteColor,
                        child: CustomText(
                         title: "A",
                          maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          textStyle: GoogleFonts.montserrat(),
                          textColor: blackColor,
                          fontSize: 30.sp,
                        ),
                      ),
                      space10h,
                      CustomText(
                        textColor: whiteColor,
                        fontSize: 15.h,
                        title: "Admin",
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        textStyle: GoogleFonts.montserrat(),
                      ),
                      CustomText(
                        textColor: whiteColor,
                        fontSize: 13.h,
                        title: FirebaseAuth.instance.currentUser!.email.toString(),
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w400,
                        textStyle: GoogleFonts.montserrat(),
                      ),
                    ],
                  ),
                ),

              space5h,
              if(!isAdmin)
                Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.home, size: 20.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 14.sp,
                        title: "Home",
                        maxLines: 1,
                        textOverflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.start,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                    space5h,
                    ListTile(
                      onTap: () {
                      //  Get.to(UserProfileScreen());
                      },
                      leading: Icon(Icons.account_circle_rounded, size: 20.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 14.sp,
                        title: "Profile",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textStyle: GoogleFonts.quicksand(),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                    ListTile(
                      onTap: () {
                       // Get.to(cataractDetect());
                      },
                      leading: Icon(Icons.remove_red_eye, size: 20.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 12.h,
                        title: "Check Eye",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textStyle: GoogleFonts.quicksand(),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.history, size: 20.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 12.h,
                        title: "History",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textStyle: GoogleFonts.quicksand(),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                    ListTile(
                      onTap: () {
                      //  Get.to(UserAppointmentsScreen());
                      },
                      leading: Icon(Icons.calendar_month, size: 20.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 12.h,
                        title: "Appointement",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textStyle: GoogleFonts.quicksand(),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                  ],
                ),
              if (isAdmin) // Show admin options only for admin
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    space10h,
                    // ListTile(
                    //   onTap: () {},
                    //   leading: Icon(Icons.person_add, size: 18.h),
                    //   title: CustomText(
                    //     textColor: Colors.white,
                    //     fontSize: 14.h,
                    //     title: "Add User",
                    //     maxline: 2,
                    //     text0verFlow: TextOverflow.ellipsis,
                    //     textAlign: TextAlign.start,
                    //     textStyle: GoogleFonts.quicksand,
                    //   ),
                    //   trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    // ),
                    space5h,
                    ListTile(
                      onTap: () {
                       // Get.to(AdminDoctorRegistrationScreen());
                      },
                      leading: Icon(Icons.person_add, size: 18.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 14.h,
                        title: "Add Doctor",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textStyle: GoogleFonts.quicksand(),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                    space5h,
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.people, size: 18.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 14.h,
                        title: "View Users",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textStyle: GoogleFonts.quicksand(),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                    space5h,
                    ListTile(
                      onTap: () {},
                      leading: Icon(Icons.people, size: 18.h),
                      title: CustomText(
                        textColor: Colors.white,
                        fontSize: 14.h,
                        title: "View Doctors",
                        maxLines: 2,
                        textOverflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        textStyle: GoogleFonts.quicksand(),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios_outlined, size: 11.h),
                    ),
                  ],
                ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
