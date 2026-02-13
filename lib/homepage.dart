import 'package:flutter/material.dart';
import 'package:project/class.dart';
import 'expensepage.dart';

class HomePage extends StatefulWidget {
  final String text;
  final int? budget;

  const HomePage({super.key, required this.text, this.budget});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int get totalSpent {
    return expenses.fold<int>(
      0,
      (sum, item) => sum + (item['amount'] as int),
    );
  }

  Map<String, int> get spentByCategory {
    final Map<String, int> data = {};

    for (final expense in expenses) {
      final String category = expense['category'];
      final int amount = expense['amount'];

      data[category] = (data[category] ?? 0) + amount;
    }

    return data;
  }

  MapEntry<String, int>? get highestSpendingCategory {
    if (spentByCategory.isEmpty) return null;

    return spentByCategory.entries.reduce(
      (a, b) => a.value > b.value ? a : b,
    );
  } 

  double get highestSpendingPercentage {
    if (highestSpendingCategory == null || widget.budget == null || widget.budget == 0) {
      return 0;
    }

    return highestSpendingCategory!.value / widget.budget!;
  }

  double get remainingBudgetPercentage {
    if (widget.budget == null || widget.budget == 0) return 0;

    final remaining = (widget.budget! - totalSpent).clamp(0, widget.budget!);
    return remaining / widget.budget!;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                if (highestSpendingCategory != null)
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue.shade400,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.all(20),
                    width: 350,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'You have spent ${(highestSpendingPercentage * 100).toStringAsFixed(0)}% '
                          'of your budget on ${highestSpendingCategory!.key}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 40, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hello, ${widget.text}!',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Container(
                    width: 350,
                    height: 170,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LinearProgressIndicator(
                            value: remainingBudgetPercentage,
                            minHeight: 10,
                            backgroundColor: Colors.white.withOpacity(0.3),
                            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          const SizedBox(height: 12),
                          topRow(context,'Monthly Budget:','\$${widget.budget ?? 0}',),
                          const SizedBox(height: 15),
                          topRow(context,'Spent:','\$$totalSpent'),
                          const SizedBox(height: 15),
                          topRow(context,'Remaining:','\$${(widget.budget ?? 0) - totalSpent}'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 200,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ExpensePage()),
                      );
                      if (result != null) {
                        setState(() {
                          if (result != null) {
                            setState(() {
                              expenses.add(result);
                            });
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                    child: const Text('Add Expense'), 
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(30, 40, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Expenses this month',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  child: Container(
                    width: 350,
                    height: 220,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade900,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ListView(
                              children: spentByCategory.entries.map((entry) {
                                return bottomRow(
                                  context,
                                  '${entry.key}:',
                                  '\$${entry.value}',
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}

Widget topRow(BuildContext context, String text, String budget) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        text,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
      Text(
        budget,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white
        ),
      ),
    ],
  );
}

Widget bottomRow(BuildContext context, String text, String budget) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
          color: Colors.white
            ),
          ),
          Text(
            budget,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
          color: Colors.white
            ),
          ),
        ],
      ),
      const SizedBox(height: 15)
    ],
  );
}