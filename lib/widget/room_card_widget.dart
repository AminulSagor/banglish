import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomCardWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const RoomCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final people = data['people'] as List<String>;

    return Card(
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      color: Colors.white,
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Room name
            Text(
              data['name'],
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: Colors.blueGrey.shade900, // deep label
              ),
            ),
            SizedBox(height: 4.h),

            // Topic
            Text(
              data['topic'],
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.blueGrey.shade600,
              ),
            ),
            SizedBox(height: 8.h),

            Row(
              children: [
                // Overlapping avatars (safe)
                SizedBox(
                  width: 80.w,
                  height: 32.h,
                  child: Stack(
                    children: List.generate(
                      people.length.clamp(0, 3),
                          (i) => Positioned(
                        left: i * 20.w,
                        child: CircleAvatar(
                          radius: 16.r,
                          backgroundColor: Colors.lightBlue.shade100,
                          child: Text(
                            people[i],
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey.shade800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                // Existence time
                Text(
                  data['createdAt'],
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(width: 10.w),

                // Join Button
                ElevatedButton(
                  onPressed: () {}, // TODO: Join logic
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1976D2), // Trustworthy blue
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "Join",
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
