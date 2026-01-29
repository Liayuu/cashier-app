// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get helloWorld => 'Hello World!';

  @override
  String get home => 'Home';

  @override
  String get promotion => 'Promotion';

  @override
  String get report => 'Report';

  @override
  String get setting => 'Setting';

  @override
  String get loginTitle => 'Login to your account';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get rememberOption => 'Remember Me';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get payment => 'payment';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get notHaveAccountMsg => 'Don\'t have an account?';

  @override
  String paymentMethodAvailability(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString payment methods are available',
      one: '1 payment method is available',
      zero: 'No payment method available',
    );
    return '$_temp0';
  }

  @override
  String paymentType(String payment) {
    String _temp0 = intl.Intl.selectLogic(
      payment,
      {
        'CASH': 'cash',
        'CREDITCARD': 'credit cart',
        'other': '$payment',
      },
    );
    return '$_temp0';
  }

  @override
  String get subTotal => 'Total Price';

  @override
  String get cash => 'Cash';

  @override
  String get change => 'Change';

  @override
  String get orderType => 'Order Type';

  @override
  String get custEmail => 'Customer email';

  @override
  String get order => 'Order';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirmPay => 'Confirm Payment';
}
