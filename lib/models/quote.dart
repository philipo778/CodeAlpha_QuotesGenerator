import 'quote_category.dart';

class Quote {
  final String text;
  final String author;
  final QuoteCategory category;

  const Quote({
    required this.text,
    required this.author,
    required this.category,
  });
}