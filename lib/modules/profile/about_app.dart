import "package:flutter/material.dart";

class AboutAppPage extends StatelessWidget {
  const AboutAppPage({super.key});

  static const String aboutAppText =
      "Banglish is a communication platform designed to help users, "
      "especially from Bangladesh, connect with others and improve their "
      "English-speaking and communication skills.\n\n"
      "Users can chat, make audio and video calls, and join rooms to talk "
      "with multiple people at once. Each room has an admin who manages the "
      "discussions, and once dismissed, the room and its messages are "
      "permanently removed—ensuring privacy and simplicity.\n\n"
      "The goal of Banglish is to build a friendly, safe, and engaging "
      "environment where Bangladeshi users can practice English "
      "conversation, meet new people, and enhance their communication "
      "confidence.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        title: const Text(
          "About App",
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            children: [
              const SizedBox(height: 12),

              /// App Icon
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: const Color(0xFFE9F1EC),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  size: 34,
                  color: Color(0xFF2D5A3A),
                ),
              ),

              const SizedBox(height: 18),

              /// App Name
              const Text(
                "Banglish",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800),
              ),

              const SizedBox(height: 4),

              /// Version
              const Text(
                "Version 1.0.0",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8A8A8A),
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 20),

              /// About Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 18,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const Text(
                  aboutAppText,
                  textAlign: TextAlign.start, // ✅ FIXED
                  style: TextStyle(
                    fontSize: 14.5,
                    height: 1.65,
                    color: Color(0xFF2B2B2B),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// Developer Note
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Developer Note",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Colors.blue.shade700,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      "Developed with ❤️ by ShafaCode.\n"
                      "This app aims to bring people closer and empower users "
                      "to speak confidently.",
                      style: TextStyle(
                        fontSize: 13.8,
                        height: 1.6,
                        color: Color(0xFF2B2B2B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              const Text(
                "© 2025 Banglish. All rights reserved.",
                style: TextStyle(
                  fontSize: 12.5,
                  color: Color(0xFF9A9A9A),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
