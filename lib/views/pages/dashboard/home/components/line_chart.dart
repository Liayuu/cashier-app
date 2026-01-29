import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/models/transaction/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

/// Lightweight custom line chart to replace `fl_chart` usage.
class LineChartDashboard extends StatefulWidget {
  const LineChartDashboard({super.key});

  @override
  State<LineChartDashboard> createState() => _LineChartDashboardState();
}

class _LineChartDashboardState extends State<LineChartDashboard> {
  final _transactionController = Get.find<TransactionController>();
  final _merchantController = Get.find<MerchantController>();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 24, 18, 12),
        child: FutureBuilder<Map<String, List<TransactionModel>>>(
          future: _transactionController.groupedTransaction(
            merchantId: _merchantController.merchant.id!,
            locationId: _merchantController.branch.id!,
          ),
          builder: (context, snapshot) {
            final data = snapshot.data;
            return CustomPaint(
              painter: _SimpleLineChartPainter(data, theme: Theme.of(context)),
              child: Container(),
            );
          },
        ),
      ),
    );
  }
}

class _SimpleLineChartPainter extends CustomPainter {
  final Map<String, List<TransactionModel>>? data;
  final ThemeData theme;

  _SimpleLineChartPainter(this.data, {required this.theme});

  double _graphNumber(int index) {
    if (data == null) return 0;
    final key = DateFormat('d', 'id_ID')
        .format(DateTime.now().subtract(Duration(days: 6 - index)));
    final list = data![key];
    if (list == null || list.isEmpty) return 0;
    final raw = list.fold<double>(0.0, (p, e) => p + (e.grandTotal ?? 0));
    // Normalize to a 0-1 range using a simple heuristic
    return (raw / 100000.0).clamp(0.0, 1.0).toDouble();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = theme.primaryColor
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    final points = List.generate(
      7,
      (i) => Offset(
          i * (size.width / 6), size.height - (_graphNumber(i) * size.height)),
    );

    if (points.isNotEmpty) path.moveTo(points.first.dx, points.first.dy);
    for (var p in points) {
      path.lineTo(p.dx, p.dy);
    }
    canvas.drawPath(path, paint);

    // draw axes
    final axisPaint = Paint()..color = theme.primaryColor.withOpacity(0.5);
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width, size.height), axisPaint);
    canvas.drawLine(const Offset(0, 0), Offset(0, size.height), axisPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
