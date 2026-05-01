import 'package:flutter/material.dart';
import '../ExpenseProvider.dart';
import '../main_screen.dart'; //IMPORT THIS

class AddEditScreen extends StatefulWidget {
  final Expense? expense;
  final int? index;

  const AddEditScreen({
    super.key,
    this.expense,
    this.index,
  });

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    titleController.text = widget.expense?.title ?? "";
    amountController.text =
        widget.expense?.amount.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final expenseProvider = ExpenseProvider.of(context);
    final isEdit = widget.expense != null;

    return MainScaffold(
      title: isEdit ? "Edit Expense" : "Add Expense", //  dynamic title

      body: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            // 📝 TITLE
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            //  AMOUNT
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 25),

            // SAVE BUTTON
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final amountText = amountController.text.trim();

                  // VALIDATION
                  if (title.isEmpty || amountText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill all fields"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  final amount = double.tryParse(amountText);

                  if (amount == null || amount <= 0) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Enter a valid amount"),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  // ➕ / ✏️ SAVE
                  if (isEdit && widget.index != null) {
                    expenseProvider.deleteExpense(widget.index!);
                    expenseProvider.addExpense(title, amount);
                  } else {
                    expenseProvider.addExpense(title, amount);
                  }

                  // SUCCESS
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        isEdit
                            ? "Expense updated successfully"
                            : "Expense saved successfully",
                      ),
                      backgroundColor: Colors.green,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Text(isEdit ? "Update" : "Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
