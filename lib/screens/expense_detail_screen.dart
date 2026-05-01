import 'package:flutter/material.dart';
import '../ExpenseProvider.dart';
import '../main_screen.dart'; // IMPORT

class ExpenseDetailScreen extends StatelessWidget {
  const ExpenseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = ExpenseProvider.of(context);
    final index = provider.selectedIndex;

    return MainScaffold(
      title: "Expense Detail",

      // Optional: better UX (no drawer on detail page)
      // showDrawer: false,

      body: index == null
          ? const Center(
        child: Text(
          "No expense selected",
          style: TextStyle(fontSize: 16),
        ),
      )
          : Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [

            const SizedBox(height: 30),

            // MAIN CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),

              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),

              child: Column(
                children: [

                  Text(
                    provider.expenses[index].title,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "TOTAL EXPENSE",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Rs ${provider.expenses[index].amount}",
                    style: const TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            //  INFO BOX
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: [

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Category"),
                      Text(provider.expenses[index].title),
                    ],
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Amount"),
                      Text("Rs ${provider.expenses[index].amount}"),
                    ],
                  ),

                  const Divider(),

                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Index"),
                      Text(index.toString()),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
