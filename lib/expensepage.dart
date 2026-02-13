import 'package:flutter/material.dart';

class ExpensePage extends StatefulWidget {
  

  const ExpensePage({super.key});

  @override
  State<ExpensePage> createState() => _ExpensePageState();
}

class _ExpensePageState extends State<ExpensePage> {
  final amtController = TextEditingController();
  final dateController = TextEditingController();
  final noteController = TextEditingController();
  String? category;

  @override
  void dispose() {
    dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dateController.text = '${picked.day}/${picked.month}/${picked.year}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
        backgroundColor: Colors.blueAccent
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  const Icon(Icons.payment, color: Colors.black),
                  const SizedBox(width: 10),
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      value: category,
                      decoration: const InputDecoration(
                        hintText: 'Select category',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'Food', child: Text('Food')),
                        DropdownMenuItem(value: 'Transport', child: Text('Transport')),
                        DropdownMenuItem(value: 'Shopping', child: Text('Shopping')),
                        DropdownMenuItem(value: 'Entertainment', child: Text('Entertainment')),
                        DropdownMenuItem(value: 'Utilities', child: Text('Utilities')),
                      ],
                      onChanged: (value) => setState(() => category = value),
                    ),
                  ),
                ],
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  const Icon(Icons.attach_money),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: amtController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Amount',
                        border: InputBorder.none, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: dateController,
                      readOnly: true,
                      onTap: _pickDate,
                      decoration: const InputDecoration(
                        hintText: 'Date',
                        border: InputBorder.none, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12)
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Icon(Icons.note),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: noteController,
                      maxLines: 10,
                      minLines: 5,
                      decoration: const InputDecoration(
                        hintText: 'Notes',
                        border: InputBorder.none, 
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 310,
            height: 40,
            child: ElevatedButton(
              onPressed: () {
                final int? amount = int.tryParse(amtController.text);

                if (category == null || amount == null || amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter valid expense details')),
                  );
                  return;
                }
                Navigator.pop(context, {
                  'category': category!,
                  'amount': amount,
                  'date': dateController.text,
                  'note': noteController.text,
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
              ),
              child: const Text('Add'), 
            ),
          ),
        ],
      ),
    );
  }
}