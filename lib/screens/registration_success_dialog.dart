import 'package:flutter/material.dart';

import 'package:workers_app/screens/subscription_plans_screen.dart';

class RegistrationSuccessDialog extends StatelessWidget {
  const RegistrationSuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      contentPadding: const EdgeInsets.all(20),
      content: SizedBox(
        width: 320,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                icon: const Icon(Icons.close, color: Colors.grey, size: 22),
                onPressed: () {
                  
                  Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const SubscriptionPlansScreen()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                color: Color(0xFF00C853),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 42,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              "Registration Completed\nSuccessfully !",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
