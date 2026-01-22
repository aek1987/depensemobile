// TODO Implement this library.

class Expense {
  final String title;
  final double amount;
  final DateTime date; // optionnel

  Expense({
    required this.title,
    required this.amount,
    DateTime? date,
  }) : this.date = date ?? DateTime.now();
}
