import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/models/room_model.dart';
import '../../../core/theme/app_colors.dart';

class RoomCardWidget extends StatelessWidget {
  final RoomModel room;
  final VoidCallback? onJoin;

  const RoomCardWidget({super.key, required this.room, this.onJoin});

  @override
  Widget build(BuildContext context) {
    final participants = room.participants;

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: AppColors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room name
            Text(
              room.name,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.blueGrey900,
              ),
            ),
            SizedBox(height: 4.h),

            // Topic
            Text(
              room.topic,
              style: TextStyle(fontSize: 14.sp, color: AppColors.blueGrey600),
            ),
            SizedBox(height: 8.h),

            Row(
              children: [
                // Overlapping avatars
                SizedBox(
                  width: 80.w,
                  height: 32.h,
                  child: Stack(
                    children: List.generate(
                      participants.length.clamp(0, 3),
                      (i) => Positioned(
                        left: i * 20.w,
                        child: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: AppColors.primaryLight.withOpacity(
                            0.3,
                          ),
                          child: Text(
                            participants[i][0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.blueGrey800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Created time
                Text(
                  room.createdAt,
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey600),
                ),
                SizedBox(width: 10.w),

                // Join Button
                ElevatedButton(
                  onPressed: onJoin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 8.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text("Join", style: TextStyle(fontSize: 14.sp)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
