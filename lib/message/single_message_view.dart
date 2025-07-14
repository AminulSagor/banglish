// single_message_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SingleMessageView extends StatelessWidget {
  final String name;
  final String photo;

  SingleMessageView({required this.name, required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: CircleAvatar(backgroundImage: NetworkImage(photo)),
        ),
        title: Text(name, style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          IconButton(onPressed: () {}, icon: Icon(Icons.videocam))
        ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0.5,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(12.w),
              children: [
                _buildMessageCard('Hi, how are you?', false),
                _buildMessageCard('I am good, thanks!', true),
                _buildMessageCard('Audio Call - 02:13', false, isCall: true),
                _buildImageMessage('https://cardinaldailyquotes.com/api/uploads/visuals/1749546661398-58444707.png', true),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              children: [
                IconButton(icon: Icon(Icons.attach_file), onPressed: () {}),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                IconButton(icon: Icon(Icons.send, color: Colors.blue), onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageCard(String text, bool isMe, {bool isCall = false}) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isCall ? Colors.green.shade100 : isMe ? Colors.blue.shade100 : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Text(text, style: TextStyle(fontSize: 14.sp)),
      ),
    );
  }

  Widget _buildImageMessage(String url, bool isMe) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4.h),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.r),
          child: Image.network(url, width: 150.w, height: 150.w, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
