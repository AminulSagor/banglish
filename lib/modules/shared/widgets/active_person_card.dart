import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/models/user_model.dart';
import '../../../core/theme/app_colors.dart';
import '../../user/messages/single_message_view.dart';

class ActivePersonCard extends StatelessWidget {
  final UserModel user;

  const ActivePersonCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final isBD = user.country.toLowerCase() == 'bangladesh';

    return GestureDetector(
      onTap: () {
        Get.to(
          () => SingleMessageView(
            name: user.name,
            photo: user.photoUrl,
            uid: user.uid,
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 6.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          leading: CircleAvatar(
            radius: 24.r,
            backgroundColor: AppColors.grey300,
            backgroundImage: user.photoUrl.isNotEmpty
                ? NetworkImage(user.photoUrl)
                : null,
            child: user.photoUrl.isEmpty
                ? Text(
                    user.name.isNotEmpty ? user.name[0] : '?',
                    style: TextStyle(
                      color: AppColors.blueGrey800,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.sp,
                    ),
                  )
                : null,
          ),
          title: Text(
            user.name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
              color: AppColors.blueGrey900,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                user.country,
                style: TextStyle(fontSize: 13.sp, color: AppColors.blueGrey600),
              ),
              if (isBD)
                Text(
                  "${user.district}, ${user.division}",
                  style: TextStyle(fontSize: 12.sp, color: AppColors.grey600),
                ),
            ],
          ),
          trailing: SizedBox(
            height: 60.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.circle, color: AppColors.activeGreen, size: 10.w),
                SizedBox(height: 1.h),
                Text(
                  'Active',
                  style: TextStyle(fontSize: 12.sp, color: AppColors.success),
                ),
                SizedBox(height: 1.h),
                Icon(Icons.chat, color: AppColors.primary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
