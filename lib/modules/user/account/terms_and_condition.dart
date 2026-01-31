import "package:flutter/material.dart";

class TermsConditionsPage extends StatelessWidget {
  const TermsConditionsPage({super.key});

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
          child: _TermsBody(),
        ),
      ),
    );
  }
}

class _TermsBody extends StatelessWidget {
  const _TermsBody();

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
        const Text("TERMS & CONDITIONS", style: titleStyle),
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
          "Welcome to Banglish (“we”, “our”, “us”). These Terms and Conditions (“Terms”) govern your use of our mobile application Banglish (the “App”). By downloading, accessing, or using our App, you agree to comply with these Terms.\n"
          "If you do not agree, please stop using the App immediately.",
          style: pStyle,
        ),

        const SizedBox(height: 22),

        const _SectionTitle("1. Overview"),
        const SizedBox(height: 8),
        const Text(
          "Banglish is a communication platform that helps users connect with others—especially Bangladeshi users—to improve their speaking and communication skills in English. The App allows users to chat, make audio/video calls, create or join rooms, and participate in discussions.",
          style: pStyle,
        ),

        const SizedBox(height: 18),
        const _SectionTitle("2. Eligibility"),
        const SizedBox(height: 8),
        const _Bullets(
          items: [
            "You must be at least 13 years old to use this App.",
            "By using the App, you confirm that the information you provide is accurate and that you have the legal capacity to agree to these Terms.",
          ],
        ),

        const SizedBox(height: 18),
        const _SectionTitle("3. Account Registration"),
        const SizedBox(height: 8),
        const Text(
          "To access certain features, you may need to create an account.\nYou agree to:",
          style: pStyle,
        ),
        const SizedBox(height: 6),
        const _Bullets(
          items: [
            "Provide accurate and up-to-date information.",
            "Keep your login credentials confidential.",
            "Be responsible for all activities under your account.",
            "We reserve the right to suspend or terminate your account if you provide false information or violate these Terms.",
          ],
        ),

        const SizedBox(height: 18),
        const _SectionTitle("4. User Conduct"),
        const SizedBox(height: 8),
        const Text(
          "You agree to use the App responsibly and not to:",
          style: pStyle,
        ),
        const SizedBox(height: 6),
        const _Bullets(
          items: [
            "Use offensive, abusive, or inappropriate language.",
            "Share false, misleading, or harmful content.",
            "Harass, bully, threaten, or harm other users.",
            "Share any sexually explicit, hateful, or illegal material.",
            "Record or distribute private chats, calls, or media without consent.",
            "Use the App for scams, spam, or any unlawful purpose.",
          ],
        ),
        const SizedBox(height: 8),
        const Text(
          "We reserve the right to suspend or remove users or rooms that violate our community rules.",
          style: pStyle,
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
