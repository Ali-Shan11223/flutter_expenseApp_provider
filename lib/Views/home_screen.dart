import 'package:expense_tracker_provider/Provider/task_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Model/task_mode.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final expenseController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense'),
        actions: [
          IconButton(
              onPressed: () {
                _showAmountDialog(context);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Consumer<TaskProvider>(builder: (context, expenseProvider, child) {
            final expenses = expenseProvider.expenses;
            return Expanded(
              child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: expenses.length,
                  itemBuilder: (context, index) {
                    final expense = expenses[index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          expense.name,
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle:
                            Text('\$${expense.amount.toStringAsFixed(2)}'),
                        trailing: IconButton(
                            onPressed: () {
                              expenseProvider.removeExpense(index);
                            },
                            icon: const Icon(
                              Icons.delete_forever,
                              color: Colors.red,
                            )),
                      ),
                    );
                  }),
            );
          })
        ],
      ),
    );
  }

  _showAmountDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add Expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: expenseController,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                      hintText: 'Expense', border: InputBorder.none),
                ),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      hintText: 'Amount', border: InputBorder.none),
                )
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Cancle',
                    style: TextStyle(color: Colors.red),
                  )),
              TextButton(
                  onPressed: () {
                    final expense = expenseController.text;
                    final amount =
                        double.tryParse(amountController.text) ?? 0.0;
                    if (expense.isNotEmpty && amount > 0) {
                      Provider.of<TaskProvider>(context, listen: false)
                          .addExpense(Expense(name: expense, amount: amount));
                      expenseController.clear();
                      amountController.clear();
                      Navigator.pop(context);
                    }
                  },
                  child: const Text(
                    'Add',
                    style: TextStyle(color: Colors.blue),
                  ))
            ],
          );
        });
  }
}
