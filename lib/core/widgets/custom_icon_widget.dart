import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';

/// Reusable icon shell for Banglish style cards and top tabs.
class CustomIconWidget extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final double size;
  final VoidCallback? onTap;

  const CustomIconWidget({
    super.key,
    required this.icon,
    this.selected = false,
    this.size = 18,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final child = AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      height: 40.h,
      width: 40.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: selected
            ? const LinearGradient(
                colors: [AppColors.gradientStart, AppColors.gradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: selected ? null : AppColors.softSurface,
        border: Border.all(
          color: selected ? Colors.transparent : AppColors.border,
        ),
      ),
      child: Icon(
        icon,
        size: size.sp,
        color: selected ? AppColors.white : AppColors.primary,
      ),
    );

    if (onTap == null) {
      return child;
    }

    return InkWell(
      borderRadius: BorderRadius.circular(12.r),
      onTap: onTap,
      child: child,
    );
  }
}
