import 'package:cashier_app/controllers/merchant_controller.dart';
import 'package:cashier_app/controllers/transaction_controller.dart';
import 'package:cashier_app/models/transaction/transaction_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class LineChartDashboard extends StatefulWidget {
  const LineChartDashboard({super.key});

  @override
  State<LineChartDashboard> createState() => _LineChartDashboardState();
}

class _LineChartDashboardState extends State<LineChartDashboard> {
  final _transactionController = Get.find<TransactionController>();
  final _merchantController = Get.find<MerchantController>();
  List<Color> gradientColors = [
    Get.theme.primaryColor.withOpacity(0.7),
    Get.theme.primaryColor,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 1.70,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 24, 18, 12),
            child: FutureBuilder<Map<String, List<TransactionModel>>>(
                future: _transactionController.groupedTransaction(
                    merchantId: _merchantController.merchant.id!,
                    locationId: _merchantController.branch.id!),
                builder: (context, snapshot) {
                  return LineChart(showAvg ? avgData() : mainData(snapshot.data));
                }),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        DateFormat('d', 'id_ID').format(DateTime.now().subtract(Duration(days: 6 - value.toInt()))),
        style: style,
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    double maxRange;
    if (_transactionController.maxGraphIncome > 1000000) {
      maxRange = (_transactionController.maxGraphIncome / 100000).roundToDouble() * 100000;
    } else {
      maxRange = 1000000;
    }
    String text;
    switch (value.toInt()) {
      case 2:
        text = NumberFormat.compact(locale: 'id_ID').format(maxRange / 10 * 2);
        break;
      case 4:
        text = NumberFormat.compact(locale: 'id_ID').format(maxRange / 10 * 4);
        break;
      case 6:
        text = NumberFormat.compact(locale: 'id_ID').format(maxRange / 10 * 6);
        break;
      case 8:
        text = NumberFormat.compact(locale: 'id_ID').format(maxRange / 10 * 8);
        break;
      case 10:
        text = NumberFormat.compact(locale: 'id_ID').format(maxRange / 10 * 10);
        break;
      default:
        return Container();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(Map<String, List<TransactionModel>>? data) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Get.theme.primaryColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Get.theme.primaryColor,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, _graphNumber(0, data)),
            FlSpot(1, _graphNumber(1, data)),
            FlSpot(2, _graphNumber(2, data)),
            FlSpot(3, _graphNumber(3, data)),
            FlSpot(4, _graphNumber(4, data)),
            FlSpot(5, _graphNumber(5, data)),
            FlSpot(6, _graphNumber(6, data)),
          ],
          isCurved: false,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: bottomTitleWidgets,
            interval: 1,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
            interval: 1,
          ),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: const [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: [
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
              ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2)!,
            ],
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
                ColorTween(begin: gradientColors[0], end: gradientColors[1])
                    .lerp(0.2)!
                    .withOpacity(0.1),
              ],
            ),
          ),
        ),
      ],
    );
  }

  double _graphNumber(int index, Map<String, List<TransactionModel>>? data) {
    if (data != null) {
      if (data[DateFormat('d', 'id_ID')
              .format(DateTime.now().subtract(Duration(days: 6 - index)))] !=
          null) {
        var raw = data[DateFormat('d', 'id_ID')
                .format(DateTime.now().subtract(Duration(days: 6 - index)))]!
            .fold(0.0, (previousValue, element) => previousValue + element.grandTotal!);
        if (_transactionController.maxGraphIncome > 1000000) {
          return raw / ((_transactionController.maxGraphIncome / 100000).roundToDouble() * 100000);
        } else {
          return raw / 100000;
        }
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }
}
