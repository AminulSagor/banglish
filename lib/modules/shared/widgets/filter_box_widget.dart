import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import 'filter_controller.dart';

class FilterBoxWidget extends GetView<FilterController> {
  const FilterBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filter by:",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blueGrey800,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            // Gender
            Expanded(
              child: Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedGender.value,
                  decoration: _decoratedField("Gender"),
                  items: ['All', 'Male', 'Female', 'Other']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedGender.value = value ?? 'All';
                  },
                ),
              ),
            ),
            SizedBox(width: 8.w),
            // Country
            Expanded(
              child: Obx(
                () => DropdownButtonFormField<String>(
                  value: controller.selectedCountry.value,
                  decoration: _decoratedField("Country"),
                  items: controller.allCountries
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (value) {
                    controller.selectedCountry.value = value ?? 'All Country';
                    controller.selectedDivision.value = '';
                    controller.selectedDistrict.value = '';
                  },
                ),
              ),
            ),
          ],
        ),
        // Show Division & District only if country == Bangladesh
        Obx(() {
          final isBD =
              controller.selectedCountry.value.toLowerCase() == 'bangladesh';
          if (!isBD) return const SizedBox.shrink();

          return Column(
            children: [
              SizedBox(height: 8.h),
              Row(
                children: [
                  // Division
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedDivision.value.isEmpty
                          ? null
                          : controller.selectedDivision.value,
                      decoration: _decoratedField("Division"),
                      items: controller.divisions
                          .map(
                            (d) => DropdownMenuItem(value: d, child: Text(d)),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.selectedDivision.value = value ?? '';
                        controller.selectedDistrict.value = '';
                      },
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // District
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: controller.selectedDistrict.value.isEmpty
                          ? null
                          : controller.selectedDistrict.value,
                      decoration: _decoratedField("District"),
                      items: controller.districts
                          .map(
                            (d) => DropdownMenuItem(value: d, child: Text(d)),
                          )
                          .toList(),
                      onChanged: (value) {
                        controller.selectedDistrict.value = value ?? '';
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }),
      ],
    );
  }

  InputDecoration _decoratedField(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: AppColors.blueGrey700,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: AppColors.grey100,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.primary, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: AppColors.grey400),
      ),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
    );
  }
}
