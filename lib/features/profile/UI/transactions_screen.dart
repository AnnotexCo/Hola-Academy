import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/components/custom_app_bar.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/not_found/not_found_screen.dart';
import 'package:hola_academy/features/profile/Data/Model/transactions_model.dart';
import 'package:hola_academy/features/profile/Logic/transactions/trans_cubit.dart';
import 'package:hola_academy/features/profile/UI/widgets/transaction_card.dart';
import 'package:intl/intl.dart';

import '../../../core/local_db/save_token.dart';

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
    context.read<TransCubit>().getTransactions();
    _loadUserRole();
  }

  Future<void> _loadUserRole() async {
    String? role = await SaveTokenDB.getRole();
    setState(() {
      _userRole = role;
    });
  }

// ---------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CustomAppBar(title: AppString.viewAllTransaction, isBack: true),
        BlocConsumer<TransCubit, TransState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            return Expanded(
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.5.w,
                    ),
                    child: Column(
                        spacing: 30.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // if (coach)
                          if (_userRole == AppString.coach) ...[
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
                                          '\$${state is TransactionsSuccess ? state.transactions.incomeStatistics.sum.finalAmount : "0.00"}',
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
                                                Navigator.pushNamed(
                                                    context,
                                                    Routes
                                                        .requestPaymentScreen);
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
                  context.read<TransCubit>().transactions == null ||
                          context
                              .read<TransCubit>()
                              .transactions!
                              .transactions
                              .isEmpty
                      ? Center(
                          child: NotFoundScreen(
                            title: 'No Transaction',
                          ),
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 38.w),
                          itemCount: state is TransactionsSuccess
                              ? context
                                  .read<TransCubit>()
                                  .transactions
                                  ?.transactions
                                  .length
                              : 0,
                          itemBuilder: (context, index) {
                            List<Transactions> transactions =
                                state is TransactionsSuccess
                                    ? context
                                            .read<TransCubit>()
                                            .transactions
                                            ?.transactions ??
                                        []
                                    : [];
                            return TransactionCard(
                              title: transactions[index].type ?? '',
                              dateTime: DateFormat('dd/MM/yyyy hh:mm a').format(
                                  DateTime.parse(
                                      transactions[index].updatedAt ?? '')),
                              price: transactions[index].finalAmount.toString(),
                              status: transactions[index].status ?? '',
                              userCase: transactions[index].userCase ?? '',
                            );
                          },
                        ),
                ],
              ),
            );
          },
        ),
      ]),
    );
  }

  // Sample transaction data
  final List<Map<String, dynamic>> transactions1 = [
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
