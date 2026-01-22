import 'package:flutter/material.dart';
import 'expense.dart';

void main() {
  runApp(const ExpenseApp());
}

class ExpenseApp extends StatelessWidget {
  const ExpenseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestion Dépenses',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Expense> expenses = [];

  final amountController = TextEditingController();
  final descController = TextEditingController();

  void addExpense() {
    if (amountController.text.isEmpty || descController.text.isEmpty) return;

    setState(() {
      expenses.add(
        Expense(
          amount: double.parse(amountController.text),
          title: descController.text,   // ✅ title
        ),
      );
    });

    amountController.clear();
    descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion de dépenses')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Montant'),
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: addExpense,
              child: const Text('Ajouter'),
            ),
          ],
        ),
      ),
    );
  }

}
