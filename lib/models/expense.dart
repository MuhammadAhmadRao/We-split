class Expense {
  final String id;
  final String title;
  final double amount;
  final String payer;
  final List<String> splitWith;
  final String category;
  final DateTime date;

  Expense({
    required this.id,
    required this.title,
    required this.amount,
    required this.payer,
    required this.splitWith,
    required this.category,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'payer': payer,
      'splitWith': splitWith,
      'category': category,
      'date': date.toIso8601String(),
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      payer: map['payer'],
      splitWith: List<String>.from(map['splitWith']),
      category: map['category'],
      date: DateTime.parse(map['date']),
    );
  }
}
