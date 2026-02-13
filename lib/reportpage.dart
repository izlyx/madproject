import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:project/historypage.dart';
import 'class.dart';


class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  int touchedIndex = -1;
  final totals = getCategoryTotals();

  double getCategoryBudgetPercent(String category, int amount) {
    if (monthlyBudget == 0) return 0;
    return amount / monthlyBudget;
  }

  final List<Color> pieColors = [
    Colors.blue.shade100,
    Colors.blue.shade300,
    Colors.blue.shade400,
    Colors.blue.shade600,
    Colors.blue.shade700,
  ];

  List<PieChartSectionData> getPieSections() {
    return totals.entries.toList().asMap().entries.map((entry) {
    final index = entry.key;
    final amount = entry.value.value;

    return PieChartSectionData(
      value: amount.toDouble(),
      title: '',
      radius: touchedIndex == index ? 70 : 60,
      color: pieColors[index % pieColors.length],
    );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Report'),
        backgroundColor: Colors.blueAccent
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: PieChart(
                PieChartData(
                  sections: getPieSections(),
                  sectionsSpace: 4,
                  centerSpaceRadius: 40,
                  pieTouchData: PieTouchData(
                    touchCallback: (event, pieTouchResponse) {
                      if (pieTouchResponse?.touchedSection != null &&
                          event is FlTapUpEvent) {
                        final index =
                            pieTouchResponse!.touchedSection!.touchedSectionIndex;
                        setState(() {
                          touchedIndex = touchedIndex == index ? -1 : index;
                        });
                      }
                    },
                  ),
                ),
              )
            ),
            expenses.isEmpty
            ? const Text(
              'No expenses yet',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            )
            : const Text('Click on each section to see details'),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade900,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Column(
                  children: totals.entries.toList().asMap().entries.map((entry) {
                    final index = entry.key;
                    final category = entry.value.key;
                    final amount = entry.value.value;
                    final color = pieColors[index % pieColors.length];
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: color,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '$category:',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '\$$amount',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                )
              ),
            ),
            if (touchedIndex != -1)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(15),
                width: 350,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Builder(
                      builder: (context) {
                        final entry = totals.entries.toList()[touchedIndex];
                        final category = entry.key;
                        final amount = entry.value;
                        final percent = getCategoryBudgetPercent(category, amount);
                        return Text(
                          '$category \$$amount (${(percent * 100).toStringAsFixed(1)}% of budget)',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 50),
            if (expenses.isNotEmpty)
            SizedBox(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                ),
                child: const Text('View History'), 
              ),
            ),
          ],
        ),
      ),
    );
  }
}