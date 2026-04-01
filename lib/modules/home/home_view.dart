import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/theme/app_colors.dart';
import '../shared/widgets/room_card_widget.dart';
import 'home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  void _openAddRoomDialog() {
    Get.dialog(
      AddRoomDialog(
        onCreate: (name, topic) {
          controller.createRoom(name, topic);
        },
      ),
      barrierDismissible: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Column(
          children: [
            const Text(
              'Language Practice Community',
              style: TextStyle(color: AppColors.primary, fontSize: 15),
            ),
            // Text(
            //   'Banglish',
            //   style: TextStyle(
            //     color: AppColors.grey800,
            //     fontSize: 9.sp,
            //     fontWeight: FontWeight.w700,
            //   ),
            // ),
          ],
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
        elevation: 0.5,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.rooms.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_call_outlined,
                  size: 64.sp,
                  color: AppColors.grey400,
                ),
                SizedBox(height: 16.h),
                Text(
                  "No active rooms.\nCreate one to get started!",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.sp, color: AppColors.grey600),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: EdgeInsets.all(16.w),
          child: ListView.builder(
            itemCount: controller.rooms.length,
            itemBuilder: (context, index) {
              final room = controller.rooms[index];
              return RoomCardWidget(
                room: room,
                onJoin: () => controller.joinRoom(room.id),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddRoomDialog(),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: AppColors.white),
      ),
    );
  }
}

class _DialogField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool autofocus;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const _DialogField({
    required this.label,
    required this.hint,
    required this.controller,
    this.autofocus = false,
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.grey800,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          autofocus: autofocus,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.grey400,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: AppColors.grey100,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.grey200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.grey200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: AppColors.primary, width: 1.2),
            ),
          ),
        ),
      ],
    );
  }
}

class AddRoomDialog extends StatefulWidget {
  final void Function(String name, String topic) onCreate;

  const AddRoomDialog({super.key, required this.onCreate});

  @override
  State<AddRoomDialog> createState() => _AddRoomDialogState();
}

class _AddRoomDialogState extends State<AddRoomDialog> {
  final _nameCtrl = TextEditingController();
  final _topicCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _topicCtrl.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _nameCtrl.text.trim().isNotEmpty && _topicCtrl.text.trim().isNotEmpty;

  void _submit() {
    if (!_canSubmit) return;
    widget.onCreate(_nameCtrl.text.trim(), _topicCtrl.text.trim());
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(18.w, 18.h, 18.w, 16.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Title
            Text(
              "Create Room",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.black,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              "Enter a room name and topic to start a discussion.",
              style: TextStyle(fontSize: 13.sp, color: AppColors.grey600),
            ),

            SizedBox(height: 16.h),

            /// Room Name
            _DialogField(
              label: "Room Name",
              hint: "e.g. IELTS Practice",
              controller: _nameCtrl,
              autofocus: true,
              onChanged: (_) => setState(() {}),
            ),

            SizedBox(height: 12.h),

            /// Topic
            _DialogField(
              label: "Topic",
              hint: "e.g. Speaking Session",
              controller: _topicCtrl,
              onChanged: (_) => setState(() {}),
              onSubmitted: (_) => _submit(),
            ),

            SizedBox(height: 18.h),

            /// Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    //onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: AppColors.grey300),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Cancel",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.grey700,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _canSubmit ? _submit : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      disabledBackgroundColor: AppColors.primary.withAlpha(89),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      "Create",
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
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
