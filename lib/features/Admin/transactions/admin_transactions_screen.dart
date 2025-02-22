import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/Admin/transactions/widgets/admin_transaction_card.dart';
import 'package:hola_academy/features/Admin/transactions/widgets/money_card.dart';
import 'package:hola_academy/features/Admin/transactions/widgets/transaction_tap_bar.dart';

class AdminTransactionsScreen extends StatefulWidget {
  const AdminTransactionsScreen({super.key});

  @override
  State<AdminTransactionsScreen> createState() =>
      _AdminTransactionsScreenState();
}

class _AdminTransactionsScreenState extends State<AdminTransactionsScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomSheet: LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              height: constraints.maxHeight * 0.70,
              width: 440.w,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: ColorManager.blackColor.withValues(alpha: .1),
                    offset: Offset(0, -2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 21.w, vertical: 30.h),
                  child: Column(spacing: 25.h, children: [
                    TransactionTapBar(
                      tabController: tabController,
                    ),
                    Expanded(
                      child: SizedBox(
                        //height: 500.h,
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: transactions.length,
                              itemBuilder: (context, index) => AdminTransactionCard(
                                title: transactions[index]['title'],
                                dateTime: transactions[index]['dateTime'],
                                price: transactions[index]['price'],
                                status: transactions[index]['status'],
                                income: transactions[index]['income'],
                              ),
                            ),
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: transactions2.length,
                              itemBuilder: (context, index) => AdminTransactionCard(
                                title: transactions2[index]['title'],
                                dateTime: transactions2[index]['dateTime'],
                                price: transactions2[index]['price'],
                                status: transactions2[index]['status'],
                                income: transactions2[index]['income'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ])),
            );
          }
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [
                  ColorManager.whiteColor,
                  ColorManager.whiteColor,
                  ColorManager.linearGradient1,
                  ColorManager.linearGradient1,
                  ColorManager.linearGradient3,
                  ColorManager.linearGradient3,
                ],
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 100.h, horizontal: 50.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MoneyCard(
                        money: '180.00,00',
                        title: AppString.moneyIn,
                        icon: ImageManager.confirm),
                    MoneyCard(
                        money: '580,00',
                        title: AppString.moneyOut,
                        icon: ImageManager.expenses),
                  ]),
            )));
  }

  // Sample transaction data
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'icon': Icons.pool,
      'income': true,
    },
    {
      'title': 'Advanced Training',
      'dateTime': '02 Jan 2025, 02:00 PM',
      'price': '70.00',
      'status': 'Confirmed',
      'icon': Icons.sports,
      'income': true,
    },
    {
      'title': 'Kids Beginner Class',
      'dateTime': '03 Jan 2025, 04:00 PM',
      'price': '40.00',
      'status': 'Canceled',
      'icon': Icons.child_care,
      'income': true,
    },
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'income': true,
    },
    {
      'title': 'Advanced Training',
      'dateTime': '02 Jan 2025, 02:00 PM',
      'price': '70.00',
      'status': 'Confirmed',
      'icon': Icons.sports,
      'income': true,
    },
    {
      'title': 'Kids Beginner Class',
      'dateTime': '03 Jan 2025, 04:00 PM',
      'price': '40.00',
      'status': 'Canceled',
      'icon': Icons.child_care,
      'income': true,
    },
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'income': true,
    },
    {
      'title': 'Advanced Training',
      'dateTime': '02 Jan 2025, 02:00 PM',
      'price': '70.00',
      'status': 'Confirmed',
      'icon': Icons.sports,
      'income': true,
    },
    {
      'title': 'Kids Beginner Class',
      'dateTime': '03 Jan 2025, 04:00 PM',
      'price': '40.00',
      'status': 'Canceled',
      'icon': Icons.child_care,
      'income': true,
    },
    // Add more transactions here
  ];

  final List<Map<String, dynamic>> transactions2 = [
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'icon': Icons.pool,
      'income': false,
    },
    {
      'title': 'Advanced Training',
      'dateTime': '02 Jan 2025, 02:00 PM',
      'price': '70.00',
      'status': 'Confirmed',
      'icon': Icons.sports,
      'income': false,
    },
    {
      'title': 'Kids Beginner Class',
      'dateTime': '03 Jan 2025, 04:00 PM',
      'price': '40.00',
      'status': 'Canceled',
      'icon': Icons.child_care,
      'income': false,
    },
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'income': false,
    },
  ];
}
