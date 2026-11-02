import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/quote.dart';
import '../models/quote_category.dart';

class FavoriteService {
  static const String _favoritesKey = 'favorite_quotes';

  // Save all favorite quotes.
  Future<void> saveFavorites(List<Quote> quotes) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> encodedQuotes = quotes.map((quote) {
      return jsonEncode({
        'text': quote.text,
        'author': quote.author,
        'category': quote.category.name,
      });
    }).toList();

    await prefs.setStringList(_favoritesKey, encodedQuotes);
  }

  // Load saved favorite quotes.
  Future<List<Quote>> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> savedQuotes =
        prefs.getStringList(_favoritesKey) ?? [];

    return savedQuotes.map((quoteJson) {
      final Map<String, dynamic> quoteMap =
      jsonDecode(quoteJson) as Map<String, dynamic>;

      return Quote(
        text: quoteMap['text'] as String,
        author: quoteMap['author'] as String,
        category: QuoteCategory.values.firstWhere(
              (category) => category.name == quoteMap['category'],
        ),
      );
    }).toList();
  }
}