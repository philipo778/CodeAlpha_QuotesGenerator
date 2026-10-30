import 'dart:math';

import '../data/quotes_data.dart';
import '../models/quote.dart';

class QuoteService {
  final Random _random = Random();

  int? _lastIndex;

  Quote getRandomQuote() {
    if (quotes.isEmpty) {
      throw StateError('No quotes available.');
    }

    if (quotes.length == 1) {
      return quotes.first;
    }

    int randomIndex;

    do {
      randomIndex = _random.nextInt(quotes.length);
    } while (randomIndex == _lastIndex);

    _lastIndex = randomIndex;

    return quotes[randomIndex];
  }
}
