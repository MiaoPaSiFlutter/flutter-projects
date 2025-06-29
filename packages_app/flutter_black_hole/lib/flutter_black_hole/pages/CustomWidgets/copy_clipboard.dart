import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_black_hole/flutter_black_hole/l10n/app_localizations.dart';

import 'package:flutter_black_hole/flutter_black_hole/pages/CustomWidgets/custom_widgets_index.dart';

void copyToClipboard({
  required BuildContext context,
  required String text,
  String? displayText,
}) {
  Clipboard.setData(ClipboardData(text: text));
  ShowSnackBar().showSnackBar(
    context,
    displayText ?? AppLocalizations.of(context).copied,
  );
}
