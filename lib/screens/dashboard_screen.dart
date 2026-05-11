import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/expense_provider.dart';
import '../widgets/neo_brutal_card.dart';
import '../widgets/neo_brutal_button.dart';
import '../theme/app_theme.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalBalance = ref.watch(totalBalanceProvider);
    final youAreOwed = ref.watch(youAreOwedProvider);
    final youOwe = ref.watch(youOweProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WE SPLIT'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'DASHBOARD',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
            ),
            const SizedBox(height: 16),
            NeoBrutalCard(
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('TOTAL BALANCE', style: TextStyle(fontWeight: FontWeight.w900)),
                  const SizedBox(height: 8),
                  Text(
                    '\$${totalBalance.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 36),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: NeoBrutalCard(
                    color: AppTheme.actionColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('YOU ARE OWED', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                          '\$${youAreOwed.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: NeoBrutalCard(
                    color: AppTheme.alertColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('YOU OWE', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 12)),
                        const SizedBox(height: 4),
                        Text(
                          '\$${youOwe.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'QUICK ACTIONS',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20),
            ),
            const SizedBox(height: 16),
            NeoBrutalButton(
              onPressed: () => Navigator.pushNamed(context, '/add-expense'),
              child: const Text('ADD NEW EXPENSE'),
            ),
            const SizedBox(height: 16),
            NeoBrutalButton(
              onPressed: () => Navigator.pushNamed(context, '/feed'),
              color: Colors.white,
              child: const Text('VIEW EXPENSE FEED'),
            ),
          ],
        ),
      ),
    );
  }
}
