import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../widgets/neo_brutal_button.dart';
import '../theme/app_theme.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  String _payer = 'You';
  final List<String> _roommates = ['Alice', 'Bob', 'Charlie'];
  final List<String> _selectedRoommates = [];

  void _submit() {
    if (_formKey.currentState!.validate() && _selectedRoommates.isNotEmpty) {
      final expense = Expense(
        id: const Uuid().v4(),
        title: _titleController.text,
        amount: double.parse(_amountController.text),
        payer: _payer,
        splitWith: List.from(_selectedRoommates),
        category: 'General',
        date: DateTime.now(),
      );

      ref.read(expenseProvider.notifier).addExpense(expense);
      Navigator.pop(context);
    } else if (_selectedRoommates.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one roommate to split with')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD EXPENSE'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'TITLE',
                  labelStyle: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) => value == null || value.isEmpty ? 'Title is required' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'AMOUNT',
                  labelStyle: const TextStyle(fontWeight: FontWeight.w900, color: Colors.black),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black, width: 3),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Amount is required';
                  if (double.tryParse(value) == null) return 'Enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              const Text('PAID BY', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              DropdownButtonFormField<String>(
                value: _payer,
                items: ['You', ..._roommates].map((name) {
                  return DropdownMenuItem(value: name, child: Text(name.toUpperCase()));
                }).toList(),
                onChanged: (val) => setState(() => _payer = val!),
                decoration: const InputDecoration(border: InputBorder.none),
              ),
              const SizedBox(height: 24),
              const Text('SPLIT WITH', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: _roommates.map((name) {
                  final isSelected = _selectedRoommates.contains(name);
                  return FilterChip(
                    label: Text(name.toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold)),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedRoommates.add(name);
                        } else {
                          _selectedRoommates.remove(name);
                        }
                      });
                    },
                    selectedColor: AppTheme.actionColor,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black, width: 2),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 40),
              NeoBrutalButton(
                onPressed: _submit,
                child: const Text('SAVE EXPENSE'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
