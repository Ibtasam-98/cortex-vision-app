import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

import '../../config/colors.dart';


Widget buildShimmerList() {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: 5, // Adjust the number of shimmer items as needed
    itemBuilder: (context, index) {
      return Padding(
        padding: EdgeInsets.only(left: 8.w, top: 5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: grey.withOpacity(0.1),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0), // Add some padding inside the container
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 110.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8), // Add space between image and name
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 100.w,
                        height: 14.h,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 4),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: 80.w,
                        height: 12.h,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}


/*
* import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../config/colors.dart';
import '../../../config/sizedbox.dart';
import '../../../controllers/user/UserHomeController.dart';
import '../../widgets/customDrawer.dart';
import '../../widgets/shimmer.dart';
import '../../widgets/text/customText.dart';
import '../../widgets/text/dualToneText.dart';
import '../../widgets/textfields/customTextFields.dart';
import 'doctor/doctorProfileForUser.dart';
import 'doctorSearchScreen.dart'; // Import the CustomDrawer widget

class UserHomeScreen extends StatefulWidget {
  final User user;


  UserHomeScreen({required this.user});

  @override
  _UserHomeScreenState createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen> {
  final _advancedDrawerController = AdvancedDrawerController();
  final UserHomeController _controller = Get.put(UserHomeController(user: FirebaseAuth.instance.currentUser!));
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEE d MMM').format(DateTime.now());
  TextEditingController searchController = TextEditingController();
  bool isIconOpen = true;

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, blackColor],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      drawer: CustomDrawer(isAdmin: false),
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          centerTitle: true,
          title: DualToneText(
            firstText: "Cortex",
            secondText: " Vision",
            firstTextStyle: GoogleFonts.montserrat,
            secondTextStyle: GoogleFonts.montserrat,
            firstTextColor: primaryColor,
            secondTextColor: blackColor,
            firstTextFontWeight: FontWeight.w500,
            secondTextFontWeight: FontWeight.bold,
            firstTextFontSize: 18.sp,
            secondTextFontSize: 18.sp,
          ),
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                isIconOpen = !value.visible;
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Image(
                    key: ValueKey<bool>(isIconOpen),
                    height: 20.h,
                    image: AssetImage(
                      isIconOpen
                          ? "assets/menu_icon.png"
                          : "assets/cross_icon.png",
                    ),
                  ),
                );
              },
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(FontAwesomeIcons.search, color: blackColor,size: 16.h,),
              tooltip: 'Search',
              onPressed: (){
               Get.to(SearchDoctorScreen());
              },
            ),
            IconButton(
              icon: Icon(Icons.logout, color: redDarkShade),
              tooltip: 'Logout',
              onPressed: _controller.logout,
            ),
          ],
        ),
        drawer: CustomDrawer(isAdmin: false),
       body: SingleChildScrollView(
         child: Padding(
           padding: EdgeInsets.symmetric(horizontal: 15.w),
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomText(
                     textColor: primaryColor,
                     fontSize: 16.sp,
                     title: "Dashboard",
                     maxline: 2,
                     text0verFlow: TextOverflow.ellipsis,
                     textAlign: TextAlign.start,
                     textStyle: GoogleFonts.montserrat,
                     fontWeight: FontWeight.w600,
                   ),
                   CustomText(
                     textColor: blackColor,
                     fontSize: 14.sp,
                     title: formattedDate,
                     maxline: 2,
                     text0verFlow: TextOverflow.ellipsis,
                     textAlign: TextAlign.start,
                     textStyle: GoogleFonts.montserrat,
                     fontWeight: FontWeight.w400,
                   ),
                 ],
               ),
               space5h,
               CustomText(
                 textColor: blackColor,
                 fontSize: 14.sp,
                 title: "Future of eye care with our \nAI technology",
                 maxline: 2,
                 text0verFlow: TextOverflow.ellipsis,
                 textAlign: TextAlign.start,
                 textStyle: GoogleFonts.montserrat,
                 //  fontWeight: FontWeight.w300,
               ),
               space10h,
               Stack(
                   children: [
                     // Image widget
                     Container(
                       height: 150.h,
                       child: ClipRRect(
                         borderRadius: BorderRadius.circular(10.0), // Adjust border radius as needed
                         child: Image.asset(
                           'assets/doctorAppointmentBg.jpg',
                           width: double.infinity, // Adjust width as needed
                           fit: BoxFit.cover, // Adjust image fit as needed
                         ),
                       ),
                     ),
                     // Black overlay with fixed size shadow
                     Positioned(
                       bottom: 0,
                       left: 0,
                       right: 0,
                       child: Container(
                         height: 150.h,
                         foregroundDecoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(10.0),
                           gradient: LinearGradient(
                             colors: [blackColor, transparent],
                             begin: Alignment.bottomCenter,
                             end: Alignment.topCenter,
                           ),
                         ),
                       ),
                     ),
                     // Text at the bottom
                     Positioned(
                         bottom: 20, // Adjust position as needed
                         left: 0,
                         right: 0,
                         child: Padding(
                           padding: EdgeInsets.only(left: 10.w),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [

                               CustomText(
                                 textColor: whiteColor,
                                 fontSize: 15.sp,
                                 title: "Discover Specialists",
                                 maxline: 2,
                                 text0verFlow: TextOverflow.ellipsis,
                                 textAlign: TextAlign.start,
                                 textStyle: GoogleFonts.montserrat,
                                 fontWeight: FontWeight.w600,
                               ),
                               Divider(color: whiteColor,thickness: 1,endIndent: 100,),
                               CustomText(
                                 textColor: whiteColor,
                                 fontSize: 12.sp,
                                 title: "Highly Qualified specialists in different fields of medicine",
                                 maxline: 3,
                                 text0verFlow: TextOverflow.ellipsis,
                                 textAlign: TextAlign.start,
                                 textStyle: GoogleFonts.montserrat,
                                 fontWeight: FontWeight.w400,
                               ),
                             ],
                           ),
                         )
                     ),
                   ]
               ),
               space10h,
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomText(
                     title: "Doctors",
                     maxline: 1,
                     text0verFlow: TextOverflow.ellipsis,
                     fontSize: 15.sp,
                     textColor: blackColor,
                     textStyle: GoogleFonts.montserrat,
                     fontWeight: FontWeight.w700,
                   ),
                   InkWell(
                     onTap: (){},
                     child: CustomText(
                       title: "View All",
                       maxline: 1,
                       text0verFlow: TextOverflow.ellipsis,
                       fontSize: 12.sp,
                       textColor: secondryColor,
                       textStyle: GoogleFonts.montserrat,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ],
               ),
               space10h,
               Row(
                 children: [
                   Expanded(
                     child: SizedBox(
                       height: 160.h,
                       child: StreamBuilder<QuerySnapshot>(
                         stream: FirebaseFirestore.instance.collection('doctors').snapshots(),
                         builder: (context, snapshot) {
                           if (snapshot.connectionState == ConnectionState.waiting) {
                             return buildShimmerList();
                           }
                           if (snapshot.hasError) {
                             return Center(child: Text('Error: ${snapshot.error}'));
                           }
                           final doctors = snapshot.data!.docs;
                           if (doctors.isEmpty) {
                             return Center(child: CustomText(
                               title:'No doctors found',
                               maxline: 1,
                               textColor: grey,
                               fontSize: 14.sp,
                               text0verFlow: TextOverflow.ellipsis,
                               textStyle: GoogleFonts.montserrat,
                               fontWeight: FontWeight.w300,
                             ));
                           }
                           return ListView.builder(
                             shrinkWrap: true,
                             scrollDirection: Axis.horizontal,
                             itemCount: doctors.length,
                             itemBuilder: (context, index) {
                               final doctor = doctors[index];
                               final Map<String, dynamic> doctorData = doctor.data() as Map<String, dynamic>;
                               final String name = doctorData['name'] ?? 'Unknown Name'; // Provide a default value
                               final String department = doctorData['department'] ?? ' - ';
                               final String imageUrl = doctorData.containsKey('imageUrl') ? (doctorData['imageUrl'] as String) : '';
                               final String aboutDr = doctorData['about'] ?? 'No Description';
                               final String specialization = doctorData['specialization'] ?? ' - ';
                               final List<String> workingDays = List<String>.from(doctorData['weekdays'] ?? []);
                               final List<Map<String, dynamic>> timeSlots = doctorData['timeSlots'] != null
                                   ? List<Map<String, dynamic>>.from(doctorData['timeSlots'])
                                   : [];

                               final Map<String, List<String>> slots = {};

                               timeSlots.forEach((slot) {
                                 final String shift = slot['shift'];
                                 final String timeSlot = slot['timeSlot'];
                                 if (!slots.containsKey(shift)) {
                                   slots[shift] = [];
                                 }
                                 slots[shift]!.add(timeSlot);
                               });




                               return Padding(
                                 padding: EdgeInsets.only(right: 10.w),
                                 child: InkWell(
                                   onTap: () {

                                     Get.to(DoctorProfileScreenForUser(
                                       doctorName: name,
                                       department: department,
                                       imageUrl: imageUrl,
                                       about: aboutDr,
                                       workingDays: workingDays,
                                       specialization: specialization,
                                       slots: slots, // Pass the slots parameter
                                     ));
                                   },
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.start,
                                     children: [
                                       Container(
                                         decoration: BoxDecoration(
                                           color: whiteColor,
                                           borderRadius: BorderRadius.circular(10.r),
                                           boxShadow: [
                                             BoxShadow(
                                               color: grey.withOpacity(0.1),
                                               spreadRadius: 2,
                                               blurRadius: 5,
                                               offset: Offset(0, 3), // changes position of shadow
                                             ),
                                           ],
                                         ),
                                         child: Padding(
                                           padding: EdgeInsets.all(8.0), // Add some padding inside the container
                                           child: Column(
                                             crossAxisAlignment: CrossAxisAlignment.start,
                                             children: [
                                               Container(
                                                 height: 110.h,
                                                 decoration: BoxDecoration(
                                                   borderRadius: BorderRadius.circular(10.r),
                                                 ),
                                                 child: ClipRRect(
                                                   borderRadius: BorderRadius.circular(10.r),
                                                   child: imageUrl.isNotEmpty
                                                       ? Image(
                                                     width: 100.w,
                                                     fit: BoxFit.cover,
                                                     image: NetworkImage(imageUrl),
                                                   )
                                                       : Image.asset(
                                                     'assets/dr_placeholder.jpeg', // Provide the path to your placeholder image
                                                     fit: BoxFit.fill,
                                                   ),
                                                 ),
                                               ),

                                               space8h,
                                               CustomText(
                                                 title: name,
                                                 maxline: 1,
                                                 text0verFlow: TextOverflow.ellipsis,
                                                 fontSize: 14.sp,
                                                 textColor: blackColor,
                                                 textStyle: GoogleFonts.montserrat,
                                               ),
                                               CustomText(
                                                 title: department,
                                                 maxline: 1,
                                                 text0verFlow: TextOverflow.ellipsis,
                                                 fontSize: 12.sp,
                                                 textColor: grey,
                                                 textStyle: GoogleFonts.quicksand,
                                               ),
                                             ],
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               );
                             },
                           );

                         },
                       ),
                     ),
                   ),
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   CustomText(
                     title: "Recent Checks",
                     maxline: 1,
                     text0verFlow: TextOverflow.ellipsis,
                     fontSize: 15.sp,
                     textColor: blackColor,
                     textStyle: GoogleFonts.montserrat,
                     fontWeight: FontWeight.w700,
                   ),
                   InkWell(
                     onTap: (){},
                     child: CustomText(
                       title: "View All",
                       maxline: 1,
                       text0verFlow: TextOverflow.ellipsis,
                       fontSize: 12.sp,
                       textColor: secondryColor,
                       textStyle: GoogleFonts.montserrat,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ],
               ),

               Row(
                   children: [
                     Expanded(
                       child: SizedBox(
                         height: 160.h,
                         width: MediaQuery.of(context).size.width,
                         child: StreamBuilder<QuerySnapshot>(
                           stream: FirebaseFirestore.instance
                               .collection('detectionResults')
                               .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                               .snapshots(),
                           builder: (context, snapshot) {
                             if (snapshot.connectionState == ConnectionState.waiting) {
                               return buildShimmerList();
                             }
                             if (snapshot.hasError) {
                               return Center(child: Text('Error: ${snapshot.error}'));
                             }
                             final detectionResults = snapshot.data!.docs;
                             if (detectionResults.isEmpty) {
                               return Center(
                                 child: CustomText(
                                   title: 'No Recent Detections found',
                                   maxline: 1,
                                   textColor: grey,
                                   fontSize: 14.sp,
                                   text0verFlow: TextOverflow.ellipsis,
                                   textStyle: GoogleFonts.montserrat,
                                   fontWeight: FontWeight.w300,
                                 ),
                               );
                             }
                             return ListView.builder(
                               shrinkWrap: true,
                               scrollDirection: Axis.horizontal,
                               itemCount: detectionResults.length,
                               itemBuilder: (context, index) {
                                 final detectionResult = detectionResults[index];
                                 final Map<String, dynamic> data = detectionResult.data() as Map<String, dynamic>;
                                 final String averageAccuracyResult = data['averageAccuracyResult'] ?? ''; // Fetch averageAccuracyResult from data
                                 final String detectionStatus = data['detectionResult'] ?? ''; // Fetch detectionResult from data
                                 final String imageURL = data['imageURL'] ?? ''; // Fetch imageURL from data
                                 final String uploadDate = data['uploadDate'] ?? ''; // Fetch uploadDate from data
                                 final String uploadTime = data['uploadTime'] ?? ''; // Fetch uploadTime from data

                                 return Padding(
                                   padding: EdgeInsets.only(right: 10.w),
                                   child: InkWell(
                                     onTap: () {},
                                     child: Column(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Container(
                                           decoration: BoxDecoration(
                                             color: whiteColor,
                                             borderRadius: BorderRadius.circular(10.r),
                                             boxShadow: [
                                               BoxShadow(
                                                 color: grey.withOpacity(0.1),
                                                 spreadRadius: 2,
                                                 blurRadius: 5,
                                                 offset: Offset(0, 3), // changes position of shadow
                                               ),
                                             ],
                                           ),
                                           child: Padding(
                                             padding: EdgeInsets.all(8.0), // Add some padding inside the container
                                             child: Column(
                                               crossAxisAlignment: CrossAxisAlignment.start,
                                               children: [
                                                 Container(
                                                   height: 110.h,
                                                   decoration: BoxDecoration(
                                                     borderRadius: BorderRadius.circular(10.r),
                                                   ),
                                                   child: ClipRRect(
                                                     borderRadius: BorderRadius.circular(10.r),
                                                     child: imageURL.isNotEmpty
                                                         ? Image(
                                                       width: 100.w,
                                                       fit: BoxFit.cover,
                                                       image: NetworkImage(imageURL),
                                                     )
                                                         : Image.asset(
                                                       'assets/dr_placeholder.jpeg', // Provide the path to your placeholder image
                                                       fit: BoxFit.fill,
                                                     ),
                                                   ),
                                                 ),

                                                 space8h,
                                                 CustomText(
                                                   title: detectionStatus,
                                                   maxline: 1,
                                                   text0verFlow: TextOverflow.ellipsis,
                                                   fontSize: 14.sp,
                                                   textColor: blackColor,
                                                   textStyle: GoogleFonts.montserrat,
                                                 ),
                                                 CustomText(
                                                   title: '$averageAccuracyResult',
                                                   maxline: 1,
                                                   text0verFlow: TextOverflow.ellipsis,
                                                   fontSize: 12.sp,
                                                   textColor: grey,
                                                   textStyle: GoogleFonts.quicksand,
                                                 ),
                                               ],
                                             ),
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 );
                               },
                             );

                           },
                         ),
                       ),
                     )
                   ],
                 ),


             ],
           ),
         ),
       )
      ),
    );
  }
  void _handleMenuButtonPressed() {
    _advancedDrawerController.showDrawer();
  }


}*/