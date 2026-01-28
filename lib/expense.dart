// TODO Implement this library.
class Expense {
  final double amount;
  final String title;
  final DateTime date;
  final String category; // nouvelle propriété

  Expense({
    required this.amount,
    required this.title,
    required this.date,
    this.category = 'Autre', // valeur par défaut
  });
}
