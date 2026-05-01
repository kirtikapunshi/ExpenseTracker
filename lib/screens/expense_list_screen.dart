import 'package:flutter/material.dart';
import '../ExpenseProvider.dart';
import '../main_screen.dart'; // IMPORT

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _ExpenseListScreenState();
}

class _ExpenseListScreenState extends State<ExpenseListScreen> {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = ExpenseProvider.of(context);
    final expenses = expenseProvider.expenses;

    return MainScaffold(
      title: "Expenses",

      body: expenses.isEmpty
          ? const Center(
        child: Text(
          "No expenses added yet",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final expense = expenses[index];

          return Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 12, vertical: 8),

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  spreadRadius: 1,
                )
              ],
            ),

            child: ListTile(
              // ICON
              leading: CircleAvatar(
                backgroundColor: Colors.blue.shade100,
                child: const Icon(
                  Icons.money,
                  color: Colors.blue,
                  size: 20,
                ),
              ),

              // TITLE
              title: Text(
                expense.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              // AMOUNT
              subtitle: Text(
                "Rs ${expense.amount}",
                style: TextStyle(color: Colors.grey[700]),
              ),

              //  ACTIONS
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [

                  //  EDIT
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.orange),
                    onPressed: () {
                      expenseProvider.selectExpense(index);
                      Navigator.pushNamed(context, '/addExpense');
                    },
                  ),

                  // DELETE
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      expenseProvider.deleteExpense(index);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Expense deleted"),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                  ),
                ],
              ),

              //OPEN DETAIL
              onTap: () {
                expenseProvider.selectExpense(index);
                Navigator.pushNamed(context, '/expense-detail');
              },
            ),
          );
        },
      ),
    );
  }
}
