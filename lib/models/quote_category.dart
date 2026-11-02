enum QuoteCategory {
  motivation,
  success,
  discipline,
  education,
  life,
  leadership,
}

extension QuoteCategoryExtension on QuoteCategory {
  String get displayName {
    switch (this) {
      case QuoteCategory.motivation:
        return 'Motivation';
      case QuoteCategory.success:
        return 'Success';
      case QuoteCategory.discipline:
        return 'Discipline';
      case QuoteCategory.education:
        return 'Education';
      case QuoteCategory.life:
        return 'Life';
      case QuoteCategory.leadership:
        return 'Leadership';
    }
  }
}