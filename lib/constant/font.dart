import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color kTextWhiteColor = Color(0xFFFFFFFF);
const Color kTextLightColor = Color(0xFFA5A5A5);
const Color kSecondaryColor = Color(0xFF6789CA);

final textTheme = GoogleFonts.poppinsTextTheme().copyWith(
  headlineSmall: GoogleFonts.chewy(
    color: kTextWhiteColor,
    fontSize: ScreenUtil().deviceType == DeviceType.tablet ? 45.sp : 40.sp,
  ),
  bodyLarge: TextStyle(
    color: kTextWhiteColor,
    fontSize: 35.0,
    fontWeight: FontWeight.bold,
  ),
  bodyMedium: TextStyle(
    color: kTextWhiteColor,
    fontSize: 28.0,
  ),
  titleMedium: TextStyle(
    color: kTextWhiteColor,
    fontSize: ScreenUtil().deviceType == DeviceType.tablet ? 14.sp : 17.sp,
    fontWeight: FontWeight.w700,
  ),
  bodySmall: GoogleFonts.poppins(
    color: kTextWhiteColor,
    fontSize: ScreenUtil().deviceType == DeviceType.tablet ? 12.sp : 13.sp,
    fontWeight: FontWeight.w200,
  ),
  labelSmall: GoogleFonts.poppins(
    color: kTextLightColor,
    fontSize: ScreenUtil().deviceType == DeviceType.tablet ? 5.sp : 7.sp,
    fontWeight: FontWeight.w300,
  ),
);
