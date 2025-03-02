import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/app_string.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';
import 'package:hola_academy/features/Admin/transactions/widgets/admin_transaction_card.dart';
import 'package:hola_academy/features/Admin/transactions/widgets/money_card.dart';
import 'package:hola_academy/features/Admin/transactions/widgets/transaction_tap_bar.dart';
import 'package:hola_academy/features/notifications/UI/loading/shimmer_notifications_list.dart';
import 'package:hola_academy/features/profile/Data/Model/transactions_model.dart';
import 'package:hola_academy/features/profile/Logic/transactions/trans_cubit.dart';
import 'package:intl/intl.dart';

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
    context.read<TransCubit>().getTransactions().then((v) {
      context.read<TransCubit>().getTransactionsByFilter(isIncome: true);
      context.read<TransCubit>().getTransactionsByFilter(isIncome: false);
    });
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
        bottomSheet: LayoutBuilder(builder: (context, constraints) {
          return BlocConsumer<TransCubit, TransState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Container(
                height: constraints.maxHeight * 0.70,
                width: 440.w,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
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
                    padding:
                        EdgeInsets.symmetric(horizontal: 21.w, vertical: 30.h),
                    child: Column(spacing: 25.h, children: [
                      TransactionTapBar(
                        tabController: tabController,
                        onTap: (p0) {
                          tabController.index == 0
                              ? context
                                  .read<TransCubit>()
                                  .getTransactionsByFilter(isIncome: true)
                              : context
                                  .read<TransCubit>()
                                  .getTransactionsByFilter(isIncome: false);
                        },
                      ),
                      Expanded(
                        child: SizedBox(
                          //height: 500.h,
                          child: state is TransactionsLoading
                              ? ShimmerNotificationsList()
                              : TabBarView(
                                  controller: tabController,
                                  children: [
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: context
                                                    .read<TransCubit>()
                                                    .incomeTransactions !=
                                                null
                                            ? context
                                                .read<TransCubit>()
                                                .incomeTransactions
                                                ?.transactions
                                                .length
                                            : 0,
                                        itemBuilder: (context, index) {
                                          List<Transactions> transactions =
                                              context
                                                      .read<TransCubit>()
                                                      .incomeTransactions
                                                      ?.transactions ??
                                                  [];
                                          return AdminTransactionCard(
                                            title:
                                                transactions[index].type ?? '',
                                            dateTime:
                                                DateFormat('dd/MM/yyyy hh:mm a')
                                                    .format(DateTime.parse(
                                                        transactions[index]
                                                                .updatedAt ??
                                                            '')),
                                            price: transactions[index]
                                                .finalAmount
                                                .toString(),
                                            status:
                                                transactions[index].status ??
                                                    '',
                                            income: true,
                                          );
                                        }),
                                    ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: context
                                                    .read<TransCubit>()
                                                    .expenseTransactions !=
                                                null
                                            ? context
                                                .read<TransCubit>()
                                                .expenseTransactions
                                                ?.transactions
                                                .length
                                            : 0,
                                        itemBuilder: (context, index) {
                                          List<Transactions> transactions =
                                              context
                                                      .read<TransCubit>()
                                                      .expenseTransactions
                                                      ?.transactions ??
                                                  [];
                                          return AdminTransactionCard(
                                            title:
                                                transactions[index].type ?? '',
                                            dateTime:
                                                DateFormat('dd/MM/yyyy hh:mm a')
                                                    .format(DateTime.parse(
                                                        transactions[index]
                                                                .updatedAt ??
                                                            '')),
                                            price: transactions[index]
                                                .finalAmount
                                                .toString(),
                                            status:
                                                transactions[index].status ??
                                                    '',
                                            income: false,
                                          );
                                        }),
                                  ],
                                ),
                        ),
                      ),
                    ])),
              );
            },
          );
        }),
        body: BlocConsumer<TransCubit, TransState>(
          listener: (context, state) {
            if (state is TransactionsFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            return Container(
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
                  padding:
                      EdgeInsets.symmetric(vertical: 100.h, horizontal: 50.w),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MoneyCard(
                            money: context
                                    .read<TransCubit>()
                                    .transactions
                                    ?.incomeStatistics
                                    .sum
                                    .finalAmount
                                    .toString() ??
                                '0.00',
                            title: AppString.moneyIn,
                            icon: ImageManager.confirm),
                        MoneyCard(
                            money: context
                                    .read<TransCubit>()
                                    .transactions
                                    ?.expenseStatistics
                                    .sum
                                    .finalAmount
                                    .toString() ??
                                '0.00',
                            title: AppString.moneyOut,
                            icon: ImageManager.expenses),
                      ]),
                ));
          },
        ));
  }

  // Sample transaction data
  final List<Map<String, dynamic>> transactions1 = [
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
