import 'package:flutter/material.dart';
import 'expense.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert'; // pour encoder/décoder JSON

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

  @override
  void initState() {
    super.initState();
    loadExpenses();
  }

  Future<void> saveExpenses() async {
    final prefs = await SharedPreferences.getInstance();

    final data = expenses.map((e) => {
      'title': e.title,
      'amount': e.amount,
      'date': e.date.toIso8601String(),
      'category': e.category,
    }).toList();

    prefs.setString('expenses', jsonEncode(data)); // on stocke tout en JSON
  }
  Future<void> loadExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('expenses');
    if (data == null) return;

    final List decoded = jsonDecode(data);
    setState(() {
      expenses.addAll(decoded.map((e) => Expense(
        title: e['title'],
        amount: e['amount'],
        date: DateTime.parse(e['date']),
        category: e['category'],
      )));
    });
  }

  double get total {
    return expenses.fold(0, (sum, e) => sum + e.amount);
  }

  void addExpense() {
    if (amountController.text.isEmpty || descController.text.isEmpty) return;

    setState(() {
      expenses.add(
        Expense(
          amount: double.parse(amountController.text),
          title: descController.text, // ✅ title
          date: DateTime.now(),
        ),
      );
    });

    amountController.clear();
    descController.clear();
    saveExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion de dépenses')),
      body: Column(
        children: [
          // FORMULAIRE
          Padding(
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
                ElevatedButton(
                  onPressed: addExpense,
                  child: const Text('Ajouter'),
                ),
              ],
            ),
          ),

          // TOTAL
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              'Total : ${total.toStringAsFixed(2)} DA',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),

          // LISTE avec suppression par glissement
          Expanded(
            child: ListView.builder(
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: ValueKey(expenses[index]),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (_) {
                    setState(() {
                      expenses.removeAt(index);
                    });  saveExpenses();
                  },
                  child: ListTile(
                    leading: const Icon(Icons.attach_money),
                    title: Text(expenses[index].title),
                    subtitle: Text(
                      '${expenses[index].amount} DA - '
                          '${expenses[index].date.day}/${expenses[index].date.month}/${expenses[index].date.year}',
                    ),
                  ),
                );
              },
            ),
          ),




        ],),);
  }
}