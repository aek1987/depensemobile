class Expense {
  final String title;
  final double amount;
  final String description; // <- ajouter ceci
  final DateTime date;

  Expense({
    required this.title,
    required this.amount,
    required this.description, // <- ajouter ceci
    DateTime? date,
  }) : this.date = date ?? DateTime.now();
}
