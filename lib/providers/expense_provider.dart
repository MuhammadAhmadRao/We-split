import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/expense.dart';

class ExpenseNotifier extends Notifier<List<Expense>> {
  @override
  List<Expense> build() {
    return [
      Expense(
        id: '1',
        title: 'PIZZA PARTY',
        amount: 45.0,
        payer: 'You',
        splitWith: ['Alice', 'Bob'],
        category: 'Food',
        date: DateTime.now(),
      ),
      Expense(
        id: '2',
        title: 'ELECTRICITY BILL',
        amount: 120.0,
        payer: 'Charlie',
        splitWith: ['You', 'Alice', 'Bob'],
        category: 'Utilities',
        date: DateTime.now(),
      ),
    ];
  }

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void deleteExpense(String id) {
    state = state.where((expense) => expense.id != id).toList();
  }

  double getTotalBalance() {
    return state.fold(0.0, (sum, expense) {
      if (expense.payer == 'You') {
        return sum + (expense.amount * (expense.splitWith.length / (expense.splitWith.length + 1)));
      } else if (expense.splitWith.contains('You')) {
        return sum - (expense.amount / (expense.splitWith.length + 1));
      }
      return sum;
    });
  }

  double getYouAreOwed() {
    return state.where((e) => e.payer == 'You').fold(0.0, (sum, expense) {
       return sum + (expense.amount * (expense.splitWith.length / (expense.splitWith.length + 1)));
    });
  }

  double getYouOwe() {
    return state.where((e) => e.splitWith.contains('You') && e.payer != 'You').fold(0.0, (sum, expense) {
       return sum + (expense.amount / (expense.splitWith.length + 1));
    });
  }
}

final expenseProvider = NotifierProvider<ExpenseNotifier, List<Expense>>(ExpenseNotifier.new);

final totalBalanceProvider = Provider((ref) {
  final expenses = ref.watch(expenseProvider);
  return ref.read(expenseProvider.notifier).getTotalBalance();
});

final youAreOwedProvider = Provider((ref) {
  final expenses = ref.watch(expenseProvider);
  return ref.read(expenseProvider.notifier).getYouAreOwed();
});

final youOweProvider = Provider((ref) {
  final expenses = ref.watch(expenseProvider);
  return ref.read(expenseProvider.notifier).getYouOwe();
});
