import "package:flutter/material.dart";

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: Colors.white,
      body: const SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(20, 6, 20, 24),
          child: _PrivacyBody(),
        ),
      ),
    );
  }
}

class _PrivacyBody extends StatelessWidget {
  const _PrivacyBody();

  @override
  Widget build(BuildContext context) {
    const titleStyle = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      letterSpacing: 1.4,
      color: Colors.black,
    );

    const mutedStyle = TextStyle(
      fontSize: 13,
      color: Color(0xFFB3B3B3),
      fontWeight: FontWeight.w600,
    );

    const pStyle = TextStyle(
      fontSize: 14.5,
      height: 1.65,
      color: Color(0xFF2B2B2B),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("PRIVACY POLICY", style: titleStyle),
        const SizedBox(height: 6),
        Row(
          children: const [
            Icon(Icons.access_time, size: 16, color: Color(0xFFB3B3B3)),
            SizedBox(width: 6),
            Text("Last Updated: 21 October, 2025", style: mutedStyle),
          ],
        ),
        const SizedBox(height: 16),

        const Text(
          "Welcome to Banglish (“we”, “our”, “us”).\n"
          "We value your privacy and are committed to protecting your personal information. "
          "This Privacy Policy explains how we collect, use, and safeguard your data when you use our mobile application Banglish (the “App”).\n\n"
          "By using our App, you agree to the terms of this Privacy Policy. If you do not agree, please discontinue using the App.",
          style: pStyle,
        ),

        const SizedBox(height: 22),

        const _SectionTitle("1. Information We Collect"),
        const SizedBox(height: 8),
        const Text(
          "We collect information to provide better services and improve user experience. The information we may collect includes:",
          style: pStyle,
        ),

        const SizedBox(height: 14),
        const _SubTitle("a. Personal Information"),
        const SizedBox(height: 6),
        const _Bullets(
          items: [
            "Account Information: such as your name, username, email address, phone number, or profile photo (if provided).",
            "Audio/Video Access: when you use voice or video calls, we access your microphone and camera only during the call session. We do not record or store your calls.",
            "Messages and Chats: text messages are transmitted securely and may be temporarily stored on our servers to deliver them to the recipient. We do not share or sell your messages.",
          ],
        ),

        const SizedBox(height: 12),
        const _SubTitle("b. Usage Information"),
        const SizedBox(height: 6),
        const _Bullets(
          items: [
            "Device information (model, operating system version, app version).",
            "Log data (IP address, session time, and app usage statistics).",
            "Information about rooms you join or create (room name, admin details, participants).",
          ],
        ),

        const SizedBox(height: 12),
        const _SubTitle("c. Permissions"),
        const SizedBox(height: 6),
        const _Bullets(
          items: [
            "Microphone and camera (for calls).",
            "Storage (for profile photos or shared media).",
            "Contacts (optional, if you want to find or invite friends).",
          ],
        ),

        const SizedBox(height: 18),
        const _SectionTitle("2. How We Use Information"),
        const SizedBox(height: 8),
        const Text("The information we collect is used to:", style: pStyle),
        const SizedBox(height: 6),
        const _Bullets(
          items: [
            "Provide and improve the App’s communication features.",
            "Ensure safety, prevent abuse, and enforce policies.",
            "Support customer service and troubleshooting.",
          ],
        ),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
    );
  }
}

class _SubTitle extends StatelessWidget {
  final String text;
  const _SubTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14.5,
        fontWeight: FontWeight.w800,
        color: Colors.black,
      ),
    );
  }
}

class _Bullets extends StatelessWidget {
  final List<String> items;
  const _Bullets({required this.items});

  @override
  Widget build(BuildContext context) {
    const bulletStyle = TextStyle(
      fontSize: 14.5,
      height: 1.65,
      color: Color(0xFF2B2B2B),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("•  ", style: bulletStyle),
                  Expanded(child: Text(t, style: bulletStyle)),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
