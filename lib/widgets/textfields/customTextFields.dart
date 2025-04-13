import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/colors.dart';

class CustomTextField extends StatefulWidget {
  final bool isPassword;
  final String label;
  final String placeholder; // Added placeholder
  final IconData icon;
  final TextEditingController textEditingController;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  CustomTextField({
    required this.label,
    required this.placeholder, // Updated constructor to accept placeholder
    required this.isPassword,
    required this.icon,
    required this.textEditingController,
    this.validator,
    this.onSaved,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Theme(
        data: ThemeData(
          hintColor: Colors.black,
        ),
        child: TextFormField(
          obscureText: widget.isPassword ? _obscureText : false,
          controller: widget.textEditingController,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(10),
            prefixIcon: Icon(widget.icon, size: 18.h),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
              onPressed: () {
                setState(() {
                  _obscureText = !_obscureText;
                });
              },
            )
                : null,
            border: InputBorder.none,
            fillColor: lightgray,
            filled: true,
            hintText: widget.placeholder, // Set the placeholder
            hintStyle: GoogleFonts.quicksand(fontSize: 12.h, color: Colors.black),
          ),
          validator: widget.validator,
          onSaved: widget.onSaved,
        ),
      ),
    );
  }
}
