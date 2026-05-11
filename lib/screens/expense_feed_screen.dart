import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/expense_provider.dart';
import '../widgets/neo_brutal_card.dart';
import '../theme/app_theme.dart';

class ExpenseFeedScreen extends ConsumerWidget {
  const ExpenseFeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expenses = ref.watch(expenseProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('EXPENSE FEED'),
      ),
      body: expenses.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'NO EXPENSES YET!',
                    style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
                  ),
                  const SizedBox(height: 16),
                  const Text('Start splitting bills with your roommates.'),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: expenses.length,
              itemBuilder: (context, index) {
                final expense = expenses[expenses.length - 1 - index]; // Show latest first
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: NeoBrutalCard(
                    color: expense.payer == 'You' ? AppTheme.actionColor : Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              expense.title.toUpperCase(),
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                            Text(
                              'Paid by ${expense.payer}',
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                            Text(
                              'Split with ${expense.splitWith.join(', ')}',
                              style: const TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Text(
                          '\$${expense.amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
