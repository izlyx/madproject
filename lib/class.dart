final Map<String, String> users = {};
List<Map<String, dynamic>> expenses = [];
int monthlyBudget = 0;
Map<String, int> getCategoryTotals() {
  Map<String, int> totals = {};

  for (var e in expenses) {
    final category = e['category'] as String;
    final amount = e['amount'] as int;

    totals[category] = (totals[category] ?? 0) + amount;
  }

  return totals;
}
