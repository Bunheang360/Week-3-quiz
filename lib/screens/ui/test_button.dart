import 'package:flutter/material.dart';
import '../../widgets/actions/bla_button.dart';

class TestButtonScreen extends StatelessWidget {
  const TestButtonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BlaButton Test'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Secondary Button with Icon
            BlaButton(
              label: 'Contact Volodia',
              icon: Icons.chat_bubble_outline,
              type: ButtonType.secondary,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Contact Volodia pressed')),
                );
              },
            ),
            
            const SizedBox(height: 16),

            // Primary Button with Icon
            BlaButton(
              label: 'Request to book',
              icon: Icons.calendar_today_outlined,
              type: ButtonType.primary,
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Request to book pressed')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
