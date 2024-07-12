import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_learning/constant/color.dart'; // Assuming this is where kPrimaryColor is defined

class Subs extends StatelessWidget {
  const Subs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Subscription',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Elevate Your C++ Expertise. Premium Learning. Unbeatable Value!',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            SubscriptionFeature(
              icon: Icons.chat_rounded,
              title: 'Unlimited AI Chatbot Access',
              description: 'Instant Answers. Uninterrupted Learning. Your C++ Companion, Anytime!',
            ),
            const SizedBox(height: 20),
            SubscriptionFeature(
              icon: Icons.video_collection,
              title: 'Exclusive and Engaging Tutorials',
              description: 'Top-Tier Tutorials. Exclusive Content. Elevate Your C++ Skills!',
            ),
            const SizedBox(height: 20),
            SubscriptionFeature(
              icon: Icons.money_off,
              title: 'Affordable Premium Subscription',
              description: 'Learn More, Spend Less. Premium Access at an Unbeatable Price!',
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Handle monthly upgrade
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Upgrade for \$1.99/month',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle weekly upgrade
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
              child: Text(
                'Upgrade for \$0.99/week',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white),
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Subscriptions renew automatically and your credit card will be charged at the end of each billing period, unless you unsubscribe at least 24 hours before. To manage your subscription, access your Apple ID profile in your device\'s settings and navigate to the Subscriptions section.',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Handle restore purchases
              },
              child: Text(
                'Restore purchases',
                style: GoogleFonts.poppins(
                  color: kPrimaryLight,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionFeature extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const SubscriptionFeature({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: kPrimaryColor, size: 30),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
