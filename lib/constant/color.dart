import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Map<int, Color> color = {
  50: Color.fromRGBO(136, 111, 242, .1),
  100: Color.fromRGBO(136, 111, 242, .2),
  200: Color.fromRGBO(136, 111, 242, .3),
  300: Color.fromRGBO(136, 111, 242, .4),
  400: Color.fromRGBO(136, 111, 242, .5),
  500: Color.fromRGBO(136, 111, 242, .6),
  600: Color.fromRGBO(136, 111, 242, .7),
  700: Color.fromRGBO(136, 111, 242, .8),
  800: Color.fromRGBO(136, 111, 242, .9),
  900: Color.fromRGBO(136, 111, 242, 1),
};

const double kDefaultPadding = 20.0;

const kHalfSizedBox = SizedBox(
  height: kDefaultPadding / 2,
);

const kWidthSizedBox = SizedBox(
  width: kDefaultPadding,
);

const kHalfWidthSizedBox = SizedBox(
  width: kDefaultPadding / 2,
);

final kBottomBorderRadius = BorderRadius.only(
  bottomRight: Radius.circular(ScreenUtil().deviceType == DeviceType.tablet ? 40.r : 20.r),
  bottomLeft: Radius.circular(ScreenUtil().deviceType == DeviceType.tablet ? 40.r : 20.r),
);

MaterialColor primaryColor = MaterialColor(0xFF886ff2, color);
const kPrimaryColor = Color(0xff6849ef);
const kPrimaryLight = Color(0xff8a72f1);
const kOtherColor = Color(0xfff2f2f2);
const kTextBlackColor = Color(0xFF000000);
