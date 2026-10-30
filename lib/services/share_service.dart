import 'package:share_plus/share_plus.dart';

import '../models/quote.dart';

class ShareService {
  Future<void> shareQuote(Quote quote) async {
    final String shareText =
        '"${quote.text}"\n\n— ${quote.author}\n\nShared from Q. QUOTES';

    await SharePlus.instance.share(ShareParams(text: shareText));
  }
}
