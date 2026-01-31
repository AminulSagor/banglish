import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';

/// App text styles
class AppTextStyles {
  AppTextStyles._();

  // Headings
  static TextStyle heading1 = TextStyle(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blueGrey900,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blueGrey900,
  );

  static TextStyle heading3 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blueGrey800,
  );

  static TextStyle heading4 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blueGrey800,
  );

  // Body
  static TextStyle bodyLarge = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.blueGrey800,
  );

  static TextStyle bodyMedium = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.blueGrey700,
  );

  static TextStyle bodySmall = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.blueGrey600,
  );

  // Labels
  static TextStyle labelLarge = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blueGrey800,
  );

  static TextStyle labelMedium = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blueGrey700,
  );

  static TextStyle labelSmall = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.blueGrey600,
  );

  // Button
  static TextStyle button = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  // Caption
  static TextStyle caption = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.grey600,
  );

  // Link
  static TextStyle link = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}
