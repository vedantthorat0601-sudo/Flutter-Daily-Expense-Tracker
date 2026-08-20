import 'package:flutter/material.dart';
import 'package:daily_expense_tracker/screens/home_page_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:daily_expense_tracker/models/expense.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  await Hive.openBox<ExpenseModel>('expenseData');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePageScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
