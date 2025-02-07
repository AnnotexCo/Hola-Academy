import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/profile/UI/widgets/transaction_card.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // final bool coach = true;
  // ------------------------------------
  String? _userRole;

  @override
  void initState() {
    super.initState();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userRole = prefs.getString('userRole');
    });
  }

// ---------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomAppBar(title: AppString.viewAllTransaction),
        Expanded(
          child: ListView(
            children: [
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 28.5.w,
                ),
                child: Column(
                    spacing: 30.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (coach)
                      if (_userRole == 'coach') ...[
                        Container(
                          height: 120.h,
                          width: 383.w,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              ColorManager.linearGradient1,
                              ColorManager.linearGradient2
                            ]),
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 35.w, top: 24.h),
                            child: Column(
                              spacing: 8.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  AppString.myBalance,
                                  style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w700,
                                      color: ColorManager.textRedColor),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      '\$998,00',
                                      style: TextStyle(
                                        fontSize: 34.sp,
                                        fontWeight: FontWeight.w500,
                                        color: ColorManager.whiteColor,
                                      ),
                                    ),
                                    Spacer(),
                                    Padding(
                                      padding: EdgeInsets.only(right: 43.w),
                                      child: Container(
                                        width: 43.w,
                                        height: 39.h,
                                        decoration: BoxDecoration(
                                          color: Color(0xffCB6928),
                                          borderRadius:
                                              BorderRadius.circular(8.r),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            Navigator.pushNamed(context, Routes.requestPaymentScreen);
                                          },
                                          icon: Icon(Icons.add,
                                              color: Colors.white),
                                          iconSize: 20.sp,
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(
                          AppString.historyTransaction,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: ColorManager.graycolorHeadline,
                          ),
                        ),
                      ],
                    ]),
              ),
              SizedBox(
                height: 18.h,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 38.w),
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return TransactionCard(
                    title: transaction['title'],
                    dateTime: transaction['dateTime'],
                    price: transaction['price'],
                    status: transaction['status'],
                  );
                },
              ),
            ],
          ),
        ),
      ]),
    );
  }

  // Sample transaction data
  final List<Map<String, dynamic>> transactions = [
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'icon': Icons.pool,
      'statusColor': Colors.orange,
    },
    {
      'title': 'Advanced Training',
      'dateTime': '02 Jan 2025, 02:00 PM',
      'price': '70.00',
      'status': 'Confirmed',
      'icon': Icons.sports,
      'statusColor': Colors.green,
    },
    {
      'title': 'Kids Beginner Class',
      'dateTime': '03 Jan 2025, 04:00 PM',
      'price': '40.00',
      'status': 'Canceled',
      'icon': Icons.child_care,
      'statusColor': Colors.red,
    },
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'icon': Icons.pool,
      'statusColor': Colors.orange,
    },
    {
      'title': 'Advanced Training',
      'dateTime': '02 Jan 2025, 02:00 PM',
      'price': '70.00',
      'status': 'Confirmed',
      'icon': Icons.sports,
      'statusColor': Colors.green,
    },
    {
      'title': 'Kids Beginner Class',
      'dateTime': '03 Jan 2025, 04:00 PM',
      'price': '40.00',
      'status': 'Canceled',
      'icon': Icons.child_care,
      'statusColor': Colors.red,
    },
    {
      'title': 'Swimming Basics',
      'dateTime': '01 Jan 2025, 10:00 AM',
      'price': '50.00',
      'status': 'Pending',
      'icon': Icons.pool,
      'statusColor': Colors.orange,
    },
    {
      'title': 'Advanced Training',
      'dateTime': '02 Jan 2025, 02:00 PM',
      'price': '70.00',
      'status': 'Confirmed',
      'icon': Icons.sports,
      'statusColor': Colors.green,
    },
    {
      'title': 'Kids Beginner Class',
      'dateTime': '03 Jan 2025, 04:00 PM',
      'price': '40.00',
      'status': 'Canceled',
      'icon': Icons.child_care,
      'statusColor': Colors.red,
    },
    // Add more transactions here
  ];
}
