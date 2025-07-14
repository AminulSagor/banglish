import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'filter_controller.dart';

class FilterBoxWidget extends StatelessWidget {
  const FilterBoxWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FilterController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Filter by:",
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey.shade800,
          ),
        ),
        SizedBox(height: 8.h),

        Row(
          children: [
            // Gender
            Expanded(
              child: DropdownButtonFormField<String>(
                value: controller.selectedGender.value.isEmpty
                    ? null
                    : controller.selectedGender.value,
                decoration: _decoratedField("Gender"),
                items: ['Male', 'Female', 'Other']
                    .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                    .toList(),
                onChanged: (value) {
                  controller.selectedGender.value = value ?? '';
                },
              ),
            ),
            SizedBox(width: 8.w),

            // Country
            Expanded(
              child: Obx(() => DropdownButtonFormField<String>(
                value: controller.selectedCountry.value,
                decoration: _decoratedField("Country"),
                items: ['Bangladesh', 'USA', 'India']
                    .map((c) =>
                    DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (value) {
                  controller.selectedCountry.value = value ?? '';
                  controller.selectedDivision.value = '';
                  controller.selectedDistrict.value = '';
                },
              )),
            ),
          ],
        ),

        // Show Division & District only if country == Bangladesh
        Obx(() {
          final isBD =
              controller.selectedCountry.value.toLowerCase() == 'bangladesh';
          return isBD
              ? Column(
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
                      items: ['Dhaka', 'Chittagong']
                          .map((d) => DropdownMenuItem(
                          value: d, child: Text(d)))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedDivision.value = value ?? '';
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
                      items: ['Gazipur', 'Narsingdi']
                          .map((d) => DropdownMenuItem(
                          value: d, child: Text(d)))
                          .toList(),
                      onChanged: (value) {
                        controller.selectedDistrict.value = value ?? '';
                      },
                    ),
                  ),
                ],
              ),
            ],
          )
              : const SizedBox.shrink();
        }),
      ],
    );
  }

  InputDecoration _decoratedField(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.blueGrey.shade700,
        fontWeight: FontWeight.w500,
      ),
      filled: true,
      fillColor: Colors.grey.shade100,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.blue.shade600, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
    );
  }
}
