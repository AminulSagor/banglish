import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widget/add_group_modal.dart';
import '../widget/room_card_widget.dart';


class RoomListView extends StatelessWidget {
  final List<Map<String, dynamic>> rooms = [
    {
      'name': 'Flutter Devs',
      'topic': 'State Management',
      'people': ['A', 'B', 'C'],
      'createdAt': '10 mins ago',
    },
    {
      'name': 'Tech Talk',
      'topic': 'AI & Ethics',
      'people': ['D', 'E'],
      'createdAt': '25 mins ago',
    },
  ];

  RoomListView({super.key});

  void _openAddGroupModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (_) => const AddGroupModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Room List'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView.builder(
          itemCount: rooms.length,
          itemBuilder: (context, index) {
            return RoomCardWidget(data: rooms[index]);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddGroupModal(context),
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}
