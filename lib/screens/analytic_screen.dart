import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../ExpenseProvider.dart';
import '../main_screen.dart'; // ✅ IMPORT

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = ExpenseProvider.of(context);
    final expenses = provider.expenses;

    // 💰 TOTAL CALCULATION
    final double total =
    expenses.fold(0, (sum, item) => sum + item.amount);

    // 🎨 COLORS
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
    ];

    return MainScaffold(
      title: "Analytics", // ✅ Shared AppBar

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            // 📊 TOTAL CARD
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300,
                    blurRadius: 8,
                    spreadRadius: 2,
                  )
                ],
              ),

              child: Column(
                children: [

                  const Text(
                    "Total Expenses",
                    style: TextStyle(color: Colors.grey),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    "Rs $total",
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 📊 PIE CHART
            SizedBox(
              height: 250,
              child: expenses.isEmpty
                  ? const Center(child: Text("No data for chart"))
                  : PieChart(
                PieChartData(
                  sections: List.generate(expenses.length, (index) {
                    final expense = expenses[index];

                    return PieChartSectionData(
                      value: expense.amount,
                      title: expense.title,
                      color: colors[index % colors.length],
                      radius: 60,
                      titleStyle: const TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
                    );
                  }),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // 📋 LIST
            Expanded(
              child: expenses.isEmpty
                  ? const Center(child: Text("No expenses found"))
                  : ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(15),

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        Text(
                          expense.title,
                          style: const TextStyle(fontSize: 16),
                        ),

                        Text(
                          "Rs ${expense.amount}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}