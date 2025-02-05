import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/title_widget.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/image_manager.dart';

class PaymentUploadSection extends StatefulWidget {
  const PaymentUploadSection({super.key});

  @override
  PaymentUploadSectionState createState() => PaymentUploadSectionState();
}

class PaymentUploadSectionState extends State<PaymentUploadSection> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  // Function to pick an image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
    }
  }

  // Show options for camera or gallery
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleWidget(title: AppString.uploadPaymentProofTitle),
        SizedBox(height: 24.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: ColorManager.backgroundLightPink,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Center(
            child: Column(
              children: [
                _selectedImage != null
                    ? Image.file(
                        _selectedImage!,
                        height: 100.h,
                        width: 100.w,
                        fit: BoxFit.cover,
                      )
                    : SvgPicture.asset(
                        ImageManager.upload,
                        height: 80.h,
                        width: 80.w,
                        fit: BoxFit.contain,
                      ),
                TextButton(
                  onPressed: _showImagePickerOptions,
                  child: TitleWidget(title: AppString.upload),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
