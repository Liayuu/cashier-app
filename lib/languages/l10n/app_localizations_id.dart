// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get helloWorld => 'Halo Dunia!';

  @override
  String get home => 'Beranda';

  @override
  String get promotion => 'Promosi';

  @override
  String get report => 'Laporan';

  @override
  String get setting => 'Pengaturan';

  @override
  String get loginTitle => 'Masuk dengan akun anda';

  @override
  String get email => 'Email';

  @override
  String get password => 'Kata sandi';

  @override
  String get rememberOption => 'Ingat saya';

  @override
  String get login => 'Masuk';

  @override
  String get register => 'Daftar';

  @override
  String get payment => 'pembayaran';

  @override
  String get paymentMethod => 'Metode Pembayaran';

  @override
  String get notHaveAccountMsg => 'Tidak punya akun?';

  @override
  String paymentMethodAvailability(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Tersedia $countString methode pembayaran',
      one: 'Tersedia 1 metode pembayaran',
      zero: 'Tidak ada metode pembayaran yang tersedia',
    );
    return '$_temp0';
  }

  @override
  String paymentType(String payment) {
    String _temp0 = intl.Intl.selectLogic(
      payment,
      {
        'CASH': 'uang tunai',
        'CREDITCARD': 'kartu kredit',
        'other': '$payment',
      },
    );
    return '$_temp0';
  }

  @override
  String get subTotal => 'Total harga';

  @override
  String get cash => 'Dibayarkan';

  @override
  String get change => 'Kembalian';

  @override
  String get orderType => 'Tipe pemesanan';

  @override
  String get custEmail => 'Email pelanggan';

  @override
  String get order => 'Pemesanan';

  @override
  String get cancel => 'Cancel';

  @override
  String get confirmPay => 'Confirm Payment';
}
