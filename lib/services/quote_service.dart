import 'dart:math';

import '../data/quotes_data.dart';
import '../models/quote.dart';

class QuoteService {
  final Random _random = Random();

  Quote getRandomQuote() {
    final randomIndex = _random.nextInt(quotes.length);

    return quotes[randomIndex];
  }
}
