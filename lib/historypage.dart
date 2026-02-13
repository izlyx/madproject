import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'class.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  int getCurrentMonthTotal() {
    return expenses.fold<int>(0, (sum, e) => sum + (e['amount'] as int));
  }

  @override
  Widget build(BuildContext context) {
    final List<int> pastMonths = [2500, 1700, 2600, 3500, 2400, 1500, 3300, 2300, 2400, 2500, 1600];
    final int currentMonth = getCurrentMonthTotal();
    final List<int> monthlySpending = [...pastMonths, currentMonth];

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: SizedBox(
              height: 250,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: true),
                  minY: 0,
                  titlesData: FlTitlesData(
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const months = [
                            'May','Jun','Jul','Aug','Sep','Oct',
                            'Nov','Dec','Jan','Feb','Mar','Apr'
                          ];
                          final index = value.toInt();
                          if (index >= 0 && index < months.length) {
                            return Text(months[index]);
                          }
                          return const SizedBox.shrink();
                        },
                        reservedSize: 32,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) =>
                            Text(value.toInt().toString()),
                        reservedSize: 40,
                      ),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        monthlySpending.length,
                        (i) => FlSpot(
                          i.toDouble(),
                          monthlySpending[i].toDouble(),
                        ),
                      ),
                      isCurved: true,
                      barWidth: 3,
                      color: Colors.blue.shade400,
                      dotData: FlDotData(show: true),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'History of expenses',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.shade900,
                borderRadius: BorderRadius.circular(30),
              ),
              child: ListView(
                children: expenses.map((e) {
                  final category = e['category'] as String;
                  final amount = e['amount'] as int;
                  final date = e['date'] as String;
                  final note = e['note'] as String;

                  return Padding(
                    padding: const EdgeInsets.fromLTRB(15,0,15,15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 80,
                              child: Text(
                                category,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 80,
                              child: Text(
                                '\$$amount',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              child: Text(
                                'Date: $date',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Note: $note',
                          style: const TextStyle(color: Colors.white70)
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
