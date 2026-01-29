import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AppLocalizations {
  final Locale locale;
  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [Locale('en')];

  // Minimal placeholder text getter. Add more keys as needed.
  String get appTitle => 'Cashier App';

  @override
  dynamic noSuchMethod(Invocation invocation) {
    // Return a human-readable fallback for missing getters or methods used in UI
    final name = invocation.memberName.toString();
    // memberName comes like Symbol("loginTitle"), extract the identifier
    final m = RegExp(r'"(.*)"').firstMatch(name);
    final id = m != null ? m.group(1) : name;
    return id ?? '---';
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.supportedLocales
      .any((l) => l.languageCode == locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) =>
      SynchronousFuture(AppLocalizations(locale));

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
