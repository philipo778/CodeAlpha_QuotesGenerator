import 'package:flutter/material.dart';

import '../models/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({super.key, required this.quote});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF151D33),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '“',
            style: TextStyle(
              fontSize: 64,
              color: Color(0xFF8B5CF6),
              height: 1,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Text(
            quote.text,
            style: const TextStyle(
              fontSize: 24,
              height: 1.5,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 24),

          Divider(color: Colors.white.withValues(alpha: 0.12)),

          const SizedBox(height: 12),

          Text(
            '— ${quote.author}',
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF22D3EE),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
