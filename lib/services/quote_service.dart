
import 'dart:math';

import '../data/quotes_data.dart';
import '../models/quote.dart';
import '../models/quote_category.dart';

class QuoteService {
  final Random _random = Random();

  int? _lastIndex;

  // Generate a random quote from all available quotes.
  Quote getRandomQuote() {
    return _getRandomQuoteFrom(quotes);
  }

  // Generate a random quote from a selected category.
  Quote getRandomQuoteByCategory(QuoteCategory category) {
    final filteredQuotes = quotes
        .where((quote) => quote.category == category)
        .toList();

    return _getRandomQuoteFrom(filteredQuotes);
  }

  // Generate a random quote from a given list.
  Quote _getRandomQuoteFrom(List<Quote> availableQuotes) {
    if (availableQuotes.isEmpty) {
      throw StateError('No quotes available for this category.');
    }

    if (availableQuotes.length == 1) {
      return availableQuotes.first;
    }

    int randomIndex;

    do {
      randomIndex = _random.nextInt(availableQuotes.length);
    } while (randomIndex == _lastIndex);

    _lastIndex = randomIndex;

    return availableQuotes[randomIndex];
  }
}
