import '../models/quote.dart';
import '../models/quote_category.dart';

const List<Quote> quotes = [
  // MOTIVATION
  Quote(
    text: 'Stay hungry, stay foolish.',
    author: 'Steve Jobs',
    category: QuoteCategory.motivation,
  ),
  Quote(
    text: 'Dream big and dare to fail.',
    author: 'Norman Vaughan',
    category: QuoteCategory.motivation,
  ),

  // SUCCESS
  Quote(
    text: 'Success is not final, failure is not fatal.',
    author: 'Winston Churchill',
    category: QuoteCategory.success,
  ),
  Quote(
    text: 'The secret of getting ahead is getting started.',
    author: 'Mark Twain',
    category: QuoteCategory.success,
  ),

  // DISCIPLINE
  Quote(
    text: 'The future depends on what you do today.',
    author: 'Mahatma Gandhi',
    category: QuoteCategory.discipline,
  ),

  // EDUCATION
  Quote(
    text: 'Great things are done by a series of small things brought together.',
    author: 'Vincent van Gogh',
    category: QuoteCategory.education,
  ),

  // LIFE
  Quote(
    text: 'It always seems impossible until it is done.',
    author: 'Nelson Mandela',
    category: QuoteCategory.life,
  ),

  // LEADERSHIP
  Quote(
    text: 'Believe you can and you are halfway there.',
    author: 'Theodore Roosevelt',
    category: QuoteCategory.leadership,
  ),
];