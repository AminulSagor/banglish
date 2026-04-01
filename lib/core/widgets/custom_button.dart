import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// Custom button widget with loading state
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget? icon;
  final bool useGradient;
  final bool isGhost;
  final bool isSocial;
  final BorderRadius? borderRadius;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.icon,
    this.useGradient = true,
    this.isGhost = false,
    this.isSocial = false,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(999.r);
    final child = _buildChild();

    final Widget buttonWidget;
    if (isOutlined || isGhost || isSocial) {
      buttonWidget = OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color: isGhost
                ? Colors.transparent
                : (backgroundColor ?? AppColors.border),
            width: 1,
          ),
          backgroundColor: isGhost
              ? Colors.transparent
              : (isSocial ? AppColors.white : AppColors.softSurface),
          minimumSize: Size(width ?? double.infinity, height ?? 40.h),
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: child,
      );
    } else {
      buttonWidget = ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: useGradient
              ? Colors.transparent
              : (backgroundColor ?? AppColors.primary),
          foregroundColor: AppColors.white,
          minimumSize: Size(width ?? double.infinity, height ?? 40.h),
          padding:
              padding ?? EdgeInsets.symmetric(vertical: 10.h, horizontal: 14.w),
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: child,
      );
    }

    if (isOutlined || isGhost || isSocial || !useGradient) {
      return SizedBox(width: width ?? double.infinity, child: buttonWidget);
    }

    return SizedBox(
      width: width ?? double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.gradientStart, AppColors.gradientEnd],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: radius,
        ),
        child: buttonWidget,
      ),
    );
  }

  Widget _buildChild() {
    if (isLoading) {
      return SizedBox(
        height: 18.h,
        width: 18.h,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(
            isOutlined || isGhost || isSocial
                ? AppColors.primary
                : AppColors.white,
          ),
        ),
      );
    }

    final resolvedTextColor =
        textColor ??
        (isOutlined || isGhost || isSocial
            ? AppColors.primary
            : AppColors.white);

    final textWidget = Text(
      text,
      style: AppTextStyles.button.copyWith(color: resolvedTextColor),
    );

    if (icon != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          icon!,
          SizedBox(width: 8.w),
          textWidget,
        ],
      );
    }

    return textWidget;
  }
}
