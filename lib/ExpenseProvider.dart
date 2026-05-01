import 'package:flutter/material.dart';

// MODEL
class Expense {
  final String title;
  final double amount;

  Expense({
    required this.title,
    required this.amount,
  });
}

/// PROVIDER
class ExpenseProvider extends InheritedWidget {
  final List<Expense> expenses;

  final Function(String, double) addExpense;
  final Function(int) deleteExpense;
  final Function(int, String, double) updateExpense;

  final Function(int) selectExpense;
  final int? selectedIndex;

  final double total;

  const ExpenseProvider({
    super.key,
    required this.expenses,
    required this.addExpense,
    required this.deleteExpense,
    required this.updateExpense,
    required this.selectExpense,
    required this.selectedIndex,
    required this.total,
    required super.child,
  });

  static ExpenseProvider of(BuildContext context) {
    final provider =
    context.dependOnInheritedWidgetOfExactType<ExpenseProvider>();

    if (provider == null) {
      throw FlutterError("ExpenseProvider not found in widget tree");
    }
    return provider;
  }

  @override
  bool updateShouldNotify(ExpenseProvider oldWidget) {
    return oldWidget.expenses.length != expenses.length ||
        oldWidget.total != total ||
        oldWidget.selectedIndex != selectedIndex;
  }
}

/// STORE
class ExpenseStore extends StatefulWidget {
  final Widget child;

  const ExpenseStore({super.key, required this.child});

  @override
  State<ExpenseStore> createState() => _ExpenseStoreState();
}

class _ExpenseStoreState extends State<ExpenseStore> {
  final List<Expense> _expenses = [];

  int? _selectedIndex;

  /// ➕ ADD
  void _addExpense(String title, double amount) {
    setState(() {
      _expenses.add(Expense(title: title, amount: amount));
    });
  }

  /// DELETE (SAFE)
  void _deleteExpense(int index) {
    if (index < 0 || index >= _expenses.length) return;

    setState(() {
      _expenses.removeAt(index);
    });
  }

  ///  UPDATE (SAFE)
  void _updateExpense(int index, String title, double amount) {
    if (index < 0 || index >= _expenses.length) return;

    setState(() {
      _expenses[index] = Expense(
        title: title,
        amount: amount,
      );
    });
  }

  ///  SELECT (FOR DETAIL SCREEN)
  void _selectExpense(int index) {
    if (index < 0 || index >= _expenses.length) return;

    setState(() {
      _selectedIndex = index;
    });
  }

  ///  TOTAL
  double get _total =>
      _expenses.fold(0, (sum, item) => sum + item.amount);

  @override
  Widget build(BuildContext context) {
    return ExpenseProvider(
      expenses: _expenses,
      addExpense: _addExpense,
      deleteExpense: _deleteExpense,
      updateExpense: _updateExpense,
      selectExpense: _selectExpense,
      selectedIndex: _selectedIndex,
      total: _total,
      child: widget.child,
    );
  }
}
