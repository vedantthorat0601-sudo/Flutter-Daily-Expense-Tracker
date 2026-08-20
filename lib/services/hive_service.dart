import 'package:hive/hive.dart';
import 'package:daily_expense_tracker/models/expense.dart';

class HiveService {
  final Box<ExpenseModel> _expenseBox =
      Hive.box<ExpenseModel>('expenseData');

  Future<void> addExpense(ExpenseModel expenseData) async {
    await _expenseBox.add(expenseData);
  }

  List<ExpenseModel> getExpenses() {
    return _expenseBox.values.toList();
  }

  Future<void> updateExpense(
    int key,
    ExpenseModel expenseData,
  ) async {
    await _expenseBox.put(key, expenseData);
  }

  Future<void> deleteExpense(int key) async {
    await _expenseBox.delete(key);
  }
}