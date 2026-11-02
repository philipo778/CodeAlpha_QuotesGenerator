
import 'package:flutter/material.dart';

import '../models/quote.dart';
import '../models/quote_category.dart';
import '../services/quote_service.dart';
import '../services/share_service.dart';
import '../services/favorite_service.dart';
import '../widgets/quote_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final QuoteService _quoteService = QuoteService();
  final ShareService _shareService = ShareService();
  final FavoriteService _favoriteService = FavoriteService();

  late Quote currentQuote;

  QuoteCategory? selectedCategory;

  final List<Quote> favoriteQuotes = [];

  bool isLoadingFavorites = true;

  @override
  void initState() {
    super.initState();

    currentQuote = _quoteService.getRandomQuote();

    loadSavedFavorites();
  }

  // Load favorites from local storage.
  Future<void> loadSavedFavorites() async {
    try {
      final savedFavorites =
      await _favoriteService.loadFavorites();

      if (!mounted) return;

      setState(() {
        favoriteQuotes
          ..clear()
          ..addAll(savedFavorites);

        isLoadingFavorites = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        isLoadingFavorites = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to load favorite quotes.'),
        ),
      );
    }
  }

  // Generate a quote based on selected category.
  void generateNewQuote() {
    setState(() {
      if (selectedCategory == null) {
        currentQuote = _quoteService.getRandomQuote();
      } else {
        currentQuote = _quoteService.getRandomQuoteByCategory(
          selectedCategory!,
        );
      }
    });
  }

  // Change selected category and generate a quote.
  void changeCategory(QuoteCategory? category) {
    setState(() {
      selectedCategory = category;

      if (category == null) {
        currentQuote = _quoteService.getRandomQuote();
      } else {
        currentQuote = _quoteService.getRandomQuoteByCategory(
          category,
        );
      }
    });
  }

  // Check whether a quote is already a favorite.
  bool isFavorite(Quote quote) {
    return favoriteQuotes.any(
          (favorite) =>
      favorite.text == quote.text &&
          favorite.author == quote.author,
    );
  }

  // Add or remove a favorite quote.
  Future<void> toggleFavorite() async {
    final alreadyFavorite = isFavorite(currentQuote);

    setState(() {
      if (alreadyFavorite) {
        favoriteQuotes.removeWhere(
              (favorite) =>
          favorite.text == currentQuote.text &&
              favorite.author == currentQuote.author,
        );
      } else {
        favoriteQuotes.add(currentQuote);
      }
    });

    try {
      await _favoriteService.saveFavorites(favoriteQuotes);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to save favorite quote.'),
        ),
      );
    }
  }

  // Share the currently displayed quote.
  Future<void> shareCurrentQuote() async {
    await _shareService.shareQuote(currentQuote);
  }

  // Remove a quote from favorites and update local storage.
  Future<void> removeFavorite(Quote quote) async {
    setState(() {
      favoriteQuotes.removeWhere(
            (favorite) =>
        favorite.text == quote.text &&
            favorite.author == quote.author,
      );
    });

    try {
      await _favoriteService.saveFavorites(favoriteQuotes);
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to update favorites.'),
        ),
      );
    }
  }

  // Display saved favorite quotes.
  void showFavorites() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF151D33),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: SizedBox(
            height: MediaQuery.of(sheetContext).size.height * 0.7,
            child: StatefulBuilder(
              builder: (context, setSheetState) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20, 20, 12, 12,
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Favorite Quotes',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () =>
                                Navigator.pop(sheetContext),
                            icon: const Icon(
                              Icons.close_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const Divider(color: Colors.white12),

                    Expanded(
                      child: isLoadingFavorites
                          ? const Center(
                        child: CircularProgressIndicator(),
                      )
                          : favoriteQuotes.isEmpty
                          ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                color: Color(0xFF22D3EE),
                                size: 56,
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No favorite quotes yet',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Tap the heart icon to save a quote.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFA7B0C0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                          : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: favoriteQuotes.length,
                        separatorBuilder: (_, __) =>
                        const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final quote =
                          favoriteQuotes[index];

                          return Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0B1020),
                              borderRadius:
                              BorderRadius.circular(16),
                              border: Border.all(
                                color: Colors.white.withValues(
                                  alpha: 0.08,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '“${quote.text}”',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 1.5,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  quote.category.displayName,
                                  style: const TextStyle(
                                    color: Color(0xFFA7B0C0),
                                    fontSize: 12,
                                  ),
                                ),

                                const SizedBox(height: 8),

                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '— ${quote.author}',
                                        style: const TextStyle(
                                          color: Color(0xFF22D3EE),
                                          fontWeight:
                                          FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      tooltip:
                                      'Remove from favorites',
                                      onPressed: () async {
                                        final removedQuote =
                                            quote;

                                        await removeFavorite(
                                          removedQuote,
                                        );

                                        setSheetState(() {});
                                      },
                                      icon: const Icon(
                                        Icons.favorite_rounded,
                                        color: Color(0xFF8B5CF6),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool currentIsFavorite = isFavorite(currentQuote);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Q. QUOTES',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Favorite quotes',
            onPressed: showFavorites,
            icon: const Icon(
              Icons.favorite_rounded,
              color: Color(0xFF22D3EE),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              const Text(
                'YOUR DAILY INSPIRATION',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  color: Color(0xFF22D3EE),
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Words that inspire greatness.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFA7B0C0),
                ),
              ),

              const SizedBox(height: 24),

              // CATEGORY SELECTOR
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFF151D33),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.08),
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<QuoteCategory?>(
                    value: selectedCategory,
                    isExpanded: true,
                    dropdownColor: const Color(0xFF151D33),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF22D3EE),
                    ),
                    hint: const Text(
                      'Select Category',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    items: [
                      const DropdownMenuItem<QuoteCategory?>(
                        value: null,
                        child: Text('All Categories'),
                      ),

                      ...QuoteCategory.values.map((category) {
                        return DropdownMenuItem<QuoteCategory?>(
                          value: category,
                          child: Text(category.displayName),
                        );
                      }),
                    ],
                    onChanged: changeCategory,
                  ),
                ),
              ),

              const Spacer(),

              // QUOTE DISPLAY
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  final slideAnimation = Tween<Offset>(
                    begin: const Offset(0, 0.08),
                    end: Offset.zero,
                  ).animate(animation);

                  return FadeTransition(
                    opacity: animation,
                    child: SlideTransition(
                      position: slideAnimation,
                      child: child,
                    ),
                  );
                },
                child: QuoteCard(
                  key: ValueKey(
                    '${currentQuote.text}-${currentQuote.author}',
                  ),
                  quote: currentQuote,
                ),
              ),

              const SizedBox(height: 12),

              // FAVORITE BUTTON
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: toggleFavorite,
                  icon: Icon(
                    currentIsFavorite
                        ? Icons.favorite_rounded
                        : Icons.favorite_border_rounded,
                    color: const Color(0xFF8B5CF6),
                  ),
                  label: Text(
                    currentIsFavorite
                        ? 'SAVED TO FAVORITES'
                        : 'ADD TO FAVORITES',
                    style: const TextStyle(
                      color: Color(0xFF22D3EE),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // NEW QUOTE BUTTON
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: generateNewQuote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8B5CF6),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'NEW QUOTE',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // SHARE BUTTON
              SizedBox(
                width: double.infinity,
                height: 54,
                child: OutlinedButton.icon(
                  onPressed: shareCurrentQuote,
                  icon: const Icon(Icons.share_rounded),
                  label: const Text(
                    'SHARE QUOTE',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF22D3EE),
                    side: const BorderSide(
                      color: Color(0xFF22D3EE),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
