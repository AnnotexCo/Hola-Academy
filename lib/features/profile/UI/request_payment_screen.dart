import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    'Reason 1',
    'Reason 2',
    'Reason 3',
  ];
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
                child: Column(
                  children: [
                    _buildAmmountField(),
                    SizedBox(height: 24.h),
                    _buildTransactionReasonField(),
                    SizedBox(height: 24.h),
                    _buildNotesField(),
                    SizedBox(height: 50.h),
                    _buildSubmitButton(),
                  ],
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
      hint: AppString.enterAmmount,
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
        if (_formKey.currentState!.validate()) {
          
        }
      },
    );
  }
}
