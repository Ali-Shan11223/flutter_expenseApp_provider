import 'package:expense_tracker_provider/Model/task_mode.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  final List<Expense> _expense = [];

  List<Expense> get expenses => _expense;

  void addExpense(Expense task) {
    _expense.add(task);
    notifyListeners();
  }

  void removeExpense(int index) {
    _expense.removeAt(index);
    notifyListeners();
  }
}
