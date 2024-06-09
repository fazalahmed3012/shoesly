import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

/// Text Styles

TextStyle headline900 (color){
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 48.sp,
            color: color
        )
    );
}
TextStyle headline800 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 36.sp,
            color: color
        )
    );
}
TextStyle headline700 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.sp,
            color: color
        )
    );
}
TextStyle headline600 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 20.sp,
            color: color
        )
    );
}
TextStyle headline500 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: color
        )
    );
}
TextStyle headline400 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 14.sp,
            color: color
        )
    );
}
TextStyle headline300 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 12.sp,
            color: color
        )
    );
}
TextStyle headline200 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: color
        )
    );
}
TextStyle headline100 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 10.sp,
            color: color
        )
    );
}
TextStyle bodyText300 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: color
        )
    );
}
TextStyle bodyText200 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14.sp,
            color: color
        )
    );
}

TextStyle bodyText100 (color) {
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            color: color
        )
    );
}

TextStyle bodyText10 (color){
    return GoogleFonts.urbanist(
        textStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 11.sp,
            color: color
        )
    );
}

/// Colors

Color primaryNeutral600 = const Color(0xFF0D0B0B);
Color primaryNeutral500 = const Color(0xFF101010);
Color primaryNeutral400 = const Color(0xFF6F6F6F);
Color primaryNeutral300 = const Color(0xFFB7B7B7);
Color primaryNeutral200 = const Color(0xFFE7E7E7);
Color primaryNeutral100 = const Color(0xFFF3F3F3);
Color primaryNeutral0 = const Color(0xFFFFFFFF);
Color primaryError500 = const Color(0xFFFF4C5E);