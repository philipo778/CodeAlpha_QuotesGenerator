import 'package:flutter/material.dart';

import '../data/quotes_data.dart';
import '../widgets/quote_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Q. QUOTES')),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'YOUR DAILY INSPIRATION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFF22D3EE),
                ),
              ),

              const SizedBox(height: 32),

              QuoteCard(quote: quotes[0]),
            ],
          ),
        ),
      ),
    );
  }
}
