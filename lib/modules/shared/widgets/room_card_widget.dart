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
    final visibleCount = participants.length.clamp(0, 3);
    final othersCount = participants.length - visibleCount;

    return Card(
      margin: EdgeInsets.only(bottom: 12.h), // ↓ less margin
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      color: AppColors.white,
      elevation: 0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.border),
          color: AppColors.blueGrey50,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h), // ↓
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryLight,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.primaryLight),
                    ),
                    child: Text(
                      room.name,
                      style: TextStyle(
                        fontSize: 13.sp, // ↓
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(width: 6.w), // ↓
                  Expanded(
                    child: Text(
                      room.topic.isEmpty ? 'English' : room.topic,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11.sp, // ↓
                        fontWeight: FontWeight.w500,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 3.h,
                    ),
                    decoration: BoxDecoration(
                      color: room.isActive
                          ? const Color(0xFFFF5B63)
                          : AppColors.grey500,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Text(
                      room.isActive ? 'LIVE' : 'OFF',
                      style: TextStyle(
                        fontSize: 9.sp, // ↓
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 12.h), // ↓

              Row(
                children: [
                  SizedBox(
                    width: 90.w, // ↓
                    height: 44.h, // ↓
                    child: Stack(
                      children: List.generate(visibleCount, (i) {
                        final avatarImage = _avatarImage(participants[i]);
                        return Positioned(
                          left: i * 24.w, // ↓ tighter overlap
                          child: Container(
                            padding: EdgeInsets.all(1.5.r),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryLight,
                                width: 1.4,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 18.r, // ↓
                              backgroundColor: AppColors.primary.withOpacity(
                                0.35,
                              ),
                              backgroundImage: avatarImage,
                              child: avatarImage == null
                                  ? Text(
                                      _avatarLabel(participants[i]),
                                      style: TextStyle(
                                        fontSize: 11.sp, // ↓
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.blueGrey800,
                                      ),
                                    )
                                  : null,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  if (othersCount > 0)
                    Text(
                      '+$othersCount',
                      style: TextStyle(
                        fontSize: 13.sp, // ↓
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                    ),
                ],
              ),

              SizedBox(height: 10.h), // ↓

              InkWell(
                onTap: onJoin,
                borderRadius: BorderRadius.circular(18.r),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 6.h), // ↓
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.gradientStart, AppColors.gradientEnd],
                    ),
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Join',
                    style: TextStyle(
                      fontSize: 13.sp, // ↓
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ImageProvider? _avatarImage(String value) {
    final trimmed = value.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return NetworkImage(trimmed);
    }
    return null;
  }

  String _avatarLabel(String value) {
    final trimmed = value.trim();
    if (trimmed.isEmpty) return '?';
    return trimmed.substring(0, 1).toUpperCase();
  }
}
