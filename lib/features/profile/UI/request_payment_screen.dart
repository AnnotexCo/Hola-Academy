import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/features/profile/Logic/transactions/trans_cubit.dart';
import '../../../core/components/custom_app_bar.dart';
import '../../../core/components/custom_app_button.dart';
import '../../../core/components/custom_text_field.dart';
import '../../../core/constants/app_string.dart';
import '../../../core/constants/color_manager.dart';
import '../../auth/register/UI/widgets/custom_drop_down_selection.dart';

class RequestPaymentScreen extends StatefulWidget {
  const RequestPaymentScreen({super.key});

  @override
  State<RequestPaymentScreen> createState() => _RequestPaymentScreenState();
}

class _RequestPaymentScreenState extends State<RequestPaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _ammountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  String? selectedReason;
  List<String> reasonOptions = [
    'SALARY',
    'WITHDRAW',
  ];
  //Amount is the amount of money to ask for in case of WITHDRAW, and the amount of hours to pay in case of SALARY

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(
              title: AppString.requestPayment,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 27.w, vertical: 27.h),
              child: Form(
                key: _formKey,
                child: BlocConsumer<TransCubit, TransState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    return Column(
                      children: [
                        _buildAmmountField(),
                        SizedBox(height: 24.h),
                        _buildTransactionReasonField(),
                        SizedBox(height: 24.h),
                        _buildNotesField(),
                        SizedBox(height: 50.h),
                        _buildSubmitButton(),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAmmountField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      controller: _ammountController,
      label: AppString.ammount,
      labelColor: ColorManager.blackFontColor,
      hint: selectedReason == 'WITHDRAW'
          ? AppString.enterMoneyAmmount
          : AppString.enterHoursAmmount,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Ammount is required";
        }
        return null;
      },
    );
  }

  Widget _buildNotesField() {
    return CustomTextField(
      controller: _notesController,
      label: AppString.notes,
      labelColor: ColorManager.blackFontColor,
      hint: AppString.additionalNotes,
      // validator: (value) {
      //   if (value == null || value.isEmpty) {
      //     return "Notes is required";
      //   }
      //   return null;
      // },
    );
  }

  Widget _buildTransactionReasonField() {
    return CustomDropDownSelection(
      value: selectedReason,
      hint: AppString.selectReason,
      label: AppString.transactionReason,
      labelColor: ColorManager.blackFontColor,
      borderColor: ColorManager.textRedColor,
      options: reasonOptions,
      onChanged: (String? newValue) {
        setState(() {
          selectedReason = newValue;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return CustomAppButton(
      text: AppString.submitRequest,
      onPressed: () {
        if (_formKey.currentState!.validate() && selectedReason != null) {
          context.read<TransCubit>().askForRefund(
                amount: _ammountController.text.isEmpty ? 0 : int.parse(_ammountController.text),
                type: selectedReason!,
                description: _notesController.text,
              );
        }
      },
    );
  }
}
