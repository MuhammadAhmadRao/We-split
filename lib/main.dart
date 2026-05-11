import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'screens/dashboard_screen.dart';
import 'screens/expense_feed_screen.dart';
import 'screens/add_expense_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: WeSplitApp(),
    ),
  );
}

class WeSplitApp extends StatelessWidget {
  const WeSplitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'We Split',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => const DashboardScreen(),
        '/feed': (context) => const ExpenseFeedScreen(),
        '/add-expense': (context) => const AddExpenseScreen(),
      },
    );
  }
}
