import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Application font-styling
///
/// User google font here for easy implementation
/// Need to have internet connection for the first time to got
/// local catch of google font on device
abstract class AppTextStyle {
  /// Google Poppins
  ///
  /// We didn't set defaults here because text constructor can have
  /// nullable values and set itself so load default values as pr
  /// device size and global theme
  static TextStyle poppins(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
