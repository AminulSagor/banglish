import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ActivePersonCard extends StatelessWidget {
  final Map<String, String> data;

  const ActivePersonCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final isBD = data['country']?.toLowerCase() == 'bangladesh';

    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
        leading: CircleAvatar(
          radius: 24.r,
          backgroundColor: Colors.grey[300],
          backgroundImage: data['image']!.isNotEmpty
              ? NetworkImage(data['image']!)
              : null,
          child: data['image']!.isEmpty
              ? Text(
            data['name']![0],
            style: TextStyle(
              color: Colors.blueGrey.shade800,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          )
              : null,
        ),
        title: Text(
          data['name'] ?? '',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
            color: Colors.blueGrey.shade900,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 4.h),
            Text(
              data['country'] ?? '',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.blueGrey.shade600,
              ),
            ),
            if (isBD)
              Text(
                "${data['district']}, ${data['division']}",
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey.shade600,
                ),
              ),
          ],
        ),
        trailing: SizedBox(
          height: 60.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.circle, color: Colors.green, size: 10.w),
              SizedBox(height: 1.h),
              Text(
                'Active',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.green.shade700,
                ),
              ),
              SizedBox(height: 1.h),
              Icon(
                Icons.chat,
                color: Colors.blue.shade600,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
