import 'package:hive/hive.dart';
part 'expense.g.dart';

@HiveType(typeId: 0)
class ExpenseModel extends HiveObject {
  @HiveField(0)
  String? title;
  @HiveField(1)
  double? totalAmount;
  @HiveField(2)
  String? category;
  @HiveField(3)
  DateTime? date;
  @HiveField(4)
  String? notes; //Optional part

  ExpenseModel({
    required this.title,
    required this.totalAmount,
    required this.category,
    required this.date,
    this.notes = "N/A",
  });
}
