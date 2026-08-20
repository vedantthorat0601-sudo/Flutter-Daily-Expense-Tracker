import 'package:flutter/material.dart';
import 'package:daily_expense_tracker/models/expense.dart';
import 'package:daily_expense_tracker/services/hive_service.dart';

//Text font Color
const Color darkText = Color(0xFF121214);
const Color whiteText = Color(0xFFF8F9FA);
const Color primaryText = Color(0xFFFFBF00);
const Color secondaryText = Color(0xFF211059);
const Color surfaceDark = Color(0xFF0D0D0D);
const Color surfaceLight = Color(0xFFF4F0FF);
const Color textSecondaryLight = Color(0xFF6B5B95);

const backgroundBlack = Colors.black;
const backgroundDarkColor = Color.fromARGB(255, 255, 255, 255);
const backgroundPurpleColor = Color.fromARGB(255, 83, 36, 251);
const backgroundSoftColor = Color(0xFFF0F8F0);
const Color primaryColorback = Color(0xFFFFBF00);

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final HiveService _hiveService = HiveService();

  List<ExpenseModel> expenses = [];

  String selectedCategory = 'All';
  String expenseCategory = 'Food';

  DateTime selectedDate = DateTime.now();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final notesController = TextEditingController();

  List<ExpenseModel> get filteredExpenses {
    if (selectedCategory == 'All') {
      return expenses;
    }

    return expenses
        .where((expense) => expense.category == selectedCategory)
        .toList();
  }

  double get totalExpenses {
    double total = 0;

    for (final expense in expenses) {
      total += expense.totalAmount ?? 0;
    }

    return total;
  }

  @override
  void initState() {
    super.initState();
    expenses = _hiveService.getExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: backgroundDarkColor,
        elevation: 0,
        scrolledUnderElevation: 0,

        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'hello!',
              style: TextStyle(
                color: primaryText,
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontFamily: 'CedarvilleCursive',
              ),
            ),
          ],
        ),

        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.black87,
              child: ClipOval(
                child: Icon(Icons.person_outlined, color: backgroundSoftColor),
              ),
            ),
          ),
        ],
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundDarkColor,
              backgroundPurpleColor,
              backgroundSoftColor,
            ],
            stops: [0.0, 0.45, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 12),
                Row(
                  children: [
                    const Text(
                      'Your Activity',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: secondaryText,
                        fontFamily: 'Telex',
                      ),
                    ),

                    SizedBox(width: 120),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFD3CCE3),
                            Color(0xFFE9E4F0),

                            //                            backgroundSoftColor,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),

                        border: Border.all(
                          color: backgroundSoftColor,
                          width: 0.1,
                          style: BorderStyle.solid,
                        ),
                      ),

                      child: Text(
                        '${_monthName(DateTime.now().month)} ${DateTime.now().day}, ${DateTime.now().year}',
                        style: const TextStyle(
                          color: darkText,
                          fontSize: 14,
                          fontFamily: 'Telex',
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 22),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),

                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                       backgroundPurpleColor,
                        Color(0xFFffa500),
                        Color(0xFFf8f8ff),
                      ],
                      stops: [0.0, 0.45, 1.0],
                    ),
                    // color: backgroundBlack,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(color: backgroundSoftColor),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            'TOTAL SPENT',
                            style: TextStyle(
                              color: darkText,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                              fontFamily: 'Telex',
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),

                            decoration: BoxDecoration(
                              color: surfaceLight,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: const Text(
                              'ALL TIME',
                              style: TextStyle(
                                color: secondaryText,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Telex',
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 14),

                      Text(
                        '₹ ${totalExpenses.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: whiteText,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Telex',
                        ),
                      ),

                      const SizedBox(height: 6),

                      const Text(
                        'Your recorded spending',
                        style: TextStyle(
                          color:whiteText,
                          fontSize: 12,
                          fontFamily: 'Telex',
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      'Transactions',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: surfaceLight,
                        fontFamily: 'Telex',
                      ),
                    ),

                    PopupMenuButton<String>(
                      color: backgroundBlack,
                      initialValue: selectedCategory,

                      onSelected: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9),
                      ),

                      itemBuilder: (context) {
                        return const [
                          PopupMenuItem(
                            value: 'All',
                            child: Text(
                              'All',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Telex',
                                color: primaryText,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Food',
                            child: Text(
                              'Food',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Telex',
                                color: primaryText,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Travel',
                            child: Text(
                              'Travel',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Telex',
                                color: primaryText,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Shopping',
                            child: Text(
                              'Shopping',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Telex',
                                color: primaryText,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Bills',
                            child: Text(
                              'Bills',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Telex',
                                color: primaryText,
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            value: 'Others',
                            child: Text(
                              'Others',
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Telex',
                                color: primaryText,
                              ),
                            ),
                          ),
                        ];
                      },

                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 13,
                          vertical: 9,
                        ),

                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: backgroundSoftColor,
                            width: 1.5,
                          ),
                          color: Colors.transparent,
                        ),

                        child: Row(
                          mainAxisSize: MainAxisSize.min,

                          children: [
                            const Icon(
                              Icons.tune_rounded,
                              size: 16,
                              color: backgroundBlack,
                            ),

                            const SizedBox(width: 6),

                            Text(
                              selectedCategory,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Telex',
                                color: whiteText,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: filteredExpenses.isEmpty
                      ? _emptyState()
                      : ListView.builder(
                          padding: const EdgeInsets.only(bottom: 90),

                          itemCount: filteredExpenses.length,

                          itemBuilder: (context, index) {
                            final expense = filteredExpenses[index];

                            return _expenseCard(expense);
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddExpenseSheet,
        backgroundColor: backgroundBlack,
        elevation: 5,

        icon: const Icon(Icons.add_rounded, color: backgroundDarkColor),
        label: const Text(
          'Add Expense',
          style: TextStyle(
            color: whiteText,
            fontWeight: FontWeight.bold,
            fontFamily: 'Telex',
          ),
        ),
      ),
    );
  }

  Widget _expenseCard(ExpenseModel expense) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),

      padding: const EdgeInsets.all(14),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            backgroundPurpleColor,
            Colors.deepPurpleAccent,
            backgroundSoftColor,
          ],
        ),
        borderRadius: BorderRadius.circular(20),

        border: Border.all(
          color: backgroundSoftColor,
          width: 0.1,
          style: BorderStyle.solid,
        ),
      ),

      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,

            decoration: BoxDecoration(
              color: backgroundDarkColor,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: surfaceDark, width: 0.5),
            ),

            child: Icon(
              _categoryIcon(expense.category),
              color: surfaceDark,
              size: 22,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  expense.title ?? 'No Title',

                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,

                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                    color: darkText,
                    fontFamily: 'Telex',
                  ),
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Card(
                      elevation: 2,
                      shadowColor: surfaceDark,
                      surfaceTintColor: primaryColorback,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                      color: backgroundDarkColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 7,
                        ),
                        child: Text(
                          expense.category ?? 'Others',
                          style: const TextStyle(
                            color: secondaryText,
                            fontSize: 11,
                            fontFamily: 'Telex',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Text('•', style: TextStyle(color: surfaceLight)),
                    ),

                    Card(
                      surfaceTintColor: backgroundPurpleColor,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(8),
                      ),
                      color: backgroundDarkColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: 7,
                        ),
                        child: Text(
                          expense.date != null
                              ? '${expense.date!.day}/${expense.date!.month}/${expense.date!.year}'
                              : 'No Date',
                          style: const TextStyle(
                            color: darkText,
                            fontWeight: FontWeight.w700,
                            fontSize: 11,
                            fontFamily: 'Telex',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: [
              Text(
                '₹ ${(expense.totalAmount ?? 0).toStringAsFixed(2)}',

                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: primaryText,
                  fontFamily: 'Telex',
                ),
              ),

              const SizedBox(height: 5),

              PopupMenuButton<String>(
                borderRadius: BorderRadius.circular(9),
                padding: EdgeInsets.all(1),
                elevation: 1,

                shadowColor: Colors.white,
                iconSize: 20,
                color: surfaceDark,

                onSelected: (value) {
                  if (value == 'edit') {
                    _showEditExpenseSheet(expense);
                  }

                  if (value == 'delete') {
                    _deleteExpense(expense);
                  }
                },

                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit_outlined,
                            size: 18,
                            color: primaryColorback,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Edit',
                            style: TextStyle(
                              fontFamily: 'Telex',
                              fontSize: 14,
                              color: whiteText,
                            ),
                          ),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete_outline,
                            size: 18,
                            color: primaryColorback,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Delete',
                            style: TextStyle(
                              fontFamily: 'Telex',
                              fontSize: 14,
                              color: whiteText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ];
                },

                child: Icon(Icons.more_horiz, color: surfaceLight),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _emptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Container(
            height: 80,
            width: 80,

            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: backgroundSoftColor),
            ),

            child: const Icon(
              Icons.receipt_long_outlined,
              color: Colors.amber,
              size: 38,
            ),
          ),

          const SizedBox(height: 20),

          Text(
            selectedCategory == 'All'
                ? 'No expenses yet'
                : 'No $selectedCategory expenses',

            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'Telex',
            ),
          ),

          const SizedBox(height: 8),

          Text(
            selectedCategory == 'All'
                ? 'Start tracking your spending by \n adding your first expense.'
                : 'There are no expenses in this category.',

            textAlign: TextAlign.center,

            style: const TextStyle(
              color: darkText,
              fontSize: 13,
              height: 1.5,
              fontFamily: 'Telex',
            ),
          ),
        ],
      ),
    );
  }

  void _showAddExpenseSheet() {
    titleController.clear();
    amountController.clear();
    notesController.clear();

    expenseCategory = 'Food';
    selectedDate = DateTime.now();

    showModalBottomSheet(
      barrierColor: Colors.black87,
      elevation: 3,
      context: context,
      isScrollControlled: true,
      backgroundColor: backgroundSoftColor,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),

      builder: (context) {
        return _expenseForm(
          title: 'Create Your Expense',
          buttonText: 'Save',
          onSave: _addExpense,
        );
      },
    );
  }

  void _showEditExpenseSheet(ExpenseModel expense) {
    titleController.text = expense.title ?? '';
    amountController.text = expense.totalAmount?.toString() ?? '';

    notesController.text = expense.notes == 'N/A' ? '' : expense.notes ?? '';

    expenseCategory = expense.category ?? 'Food';

    selectedDate = expense.date ?? DateTime.now();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: backgroundSoftColor,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      builder: (context) {
        return _expenseForm(
          title: 'Edit Expense',
          buttonText: 'Update Expense',
          onSave: () => _updateExpense(expense),
        );
      },
    );
  }

  Widget _expenseForm({
    required String title,
    required String buttonText,
    required VoidCallback onSave,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 22,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),

      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Center(
              child: Container(
                height: 4,
                width: 40,

                decoration: BoxDecoration(
                  color: backgroundDarkColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 22),

            Text(
              title,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'Telex',
                color: backgroundPurpleColor,
              ),
            ),

            const SizedBox(height: 5),

            const Text(
              'Enter the details of your expense',
              style: TextStyle(
                color: textSecondaryLight,
                fontSize: 15,
                fontFamily: 'Telex',
              ),
            ),

            const SizedBox(height: 22),

            _inputField(
              controller: titleController,
              label: 'Expense Title',
              hint: 'e.g. Cafe Bill',
              icon: Icons.edit_note_outlined,
            ),

            const SizedBox(height: 14),

            _inputField(
              controller: amountController,
              label: 'Amount',
              hint: 'e.g. 500/-',
              icon: Icons.currency_rupee,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 14),

            DropdownButtonFormField<String>(
              initialValue: expenseCategory,

              decoration: _inputDecoration(
                label: 'Category',
                icon: Icons.category_outlined,
              ),

              items: const [
                DropdownMenuItem(value: 'Food', child: Text('Food')),
                DropdownMenuItem(value: 'Travel', child: Text('Travel')),
                DropdownMenuItem(value: 'Shopping', child: Text('Shopping')),
                DropdownMenuItem(value: 'Bills', child: Text('Bills')),
                DropdownMenuItem(value: 'Others', child: Text('Others')),
              ],

              onChanged: (value) {
                setState(() {
                  expenseCategory = value!;
                });
              },
            ),

            const SizedBox(height: 14),

            GestureDetector(
              onTap: _selectDate,

              child: Container(
                width: double.infinity,

                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 17,
                ),

                decoration: BoxDecoration(
                  color: backgroundSoftColor,
                  borderRadius: BorderRadius.circular(15),

                  border: Border.all(color: primaryColorback),
                ),

                child: Row(
                  children: [
                    const Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: backgroundBlack,
                    ),

                    const SizedBox(width: 12),

                    const Text('Date', style: TextStyle(fontFamily: 'Telex')),

                    const Spacer(),

                    Text(
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Telex',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 14),

            _inputField(
              controller: notesController,
              label: 'Notes',
              hint: 'Optional',
              icon: Icons.notes_outlined,
              maxLines: 3,
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 54,

              child: ElevatedButton(
                onPressed: onSave,

                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundPurpleColor,
                  foregroundColor: whiteText,

                  elevation: 3,
                  shadowColor: secondaryText,
                  surfaceTintColor: backgroundBlack,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(
                      color: textSecondaryLight,
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),

                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Telex',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,

      decoration: _inputDecoration(label: label, hint: hint, icon: icon),
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,

      prefixIcon: Icon(icon, size: 20),

      filled: true,
      fillColor: backgroundSoftColor,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: primaryColorback),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: primaryColorback),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: primaryColorback, width: 1.5),
      ),
    );
  }

  Future<void> _addExpense() async {
    final title = titleController.text.trim();

    final amount = double.tryParse(amountController.text.trim());

    if (title.isEmpty || amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid title and amount')),
      );

      return;
    }

    final newExpense = ExpenseModel(
      title: title,
      totalAmount: amount,
      category: expenseCategory,
      date: selectedDate,
      notes: notesController.text.trim().isEmpty
          ? 'N/A'
          : notesController.text.trim(),
    );

    await _hiveService.addExpense(newExpense);

    setState(() {
      expenses = _hiveService.getExpenses();
    });

    titleController.clear();
    amountController.clear();
    notesController.clear();

    Navigator.pop(context);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Expense added successfully')));
  }

  Future<void> _updateExpense(ExpenseModel expense) async {
    final title = titleController.text.trim();

    final amount = double.tryParse(amountController.text.trim());

    if (title.isEmpty || amount == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid title and amount')),
      );

      return;
    }

    final updatedExpense = ExpenseModel(
      title: title,
      totalAmount: amount,
      category: expenseCategory,
      date: selectedDate,
      notes: notesController.text.trim().isEmpty
          ? 'N/A'
          : notesController.text.trim(),
    );

    await _hiveService.updateExpense(expense.key, updatedExpense);

    setState(() {
      expenses = _hiveService.getExpenses();
    });

    titleController.clear();
    amountController.clear();
    notesController.clear();

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense updated successfully')),
    );
  }

  Future<void> _deleteExpense(ExpenseModel expense) async {
    final shouldDelete = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          title: const Text(
            'Delete Expense?',
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Telex'),
          ),

          content: Text(
            'Are you sure you want to delete "${expense.title}"?',
            style: const TextStyle(fontFamily: 'Telex'),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },

              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black, fontFamily: 'Telex'),
              ),
            ),

            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, true);
              },

              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundBlack,
                foregroundColor: primaryText,
              ),

              child: const Text(
                'Delete',
                style: TextStyle(fontFamily: 'Telex'),
              ),
            ),
          ],
        );
      },
    );

    if (shouldDelete != true) {
      return;
    }

    await _hiveService.deleteExpense(expense.key);

    setState(() {
      expenses = _hiveService.getExpenses();
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Expense deleted successfully')),
    );
  }

  Future<void> _selectDate() async {
    final pickedDate = await showDatePicker(
      context: context,

      initialDate: selectedDate,

      firstDate: DateTime(2020),

      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  IconData _categoryIcon(String? category) {
    switch (category) {
      case 'Food':
        return Icons.restaurant_outlined;

      case 'Travel':
        return Icons.directions_car_outlined;

      case 'Shopping':
        return Icons.shopping_bag_outlined;

      case 'Bills':
        return Icons.receipt_long_outlined;

      default:
        return Icons.more_horiz;
    }
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return months[month - 1];
  }
}
