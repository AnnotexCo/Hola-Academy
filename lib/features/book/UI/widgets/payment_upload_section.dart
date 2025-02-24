import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/components/title_widget.dart';
import '../../../../core/constants/app_string.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/image_manager.dart';

class PaymentUploadSection extends StatefulWidget {
  final ValueChanged<File?> onImageSelected;

  const PaymentUploadSection({super.key, required this.onImageSelected});

  @override
  State<PaymentUploadSection> createState() => _PaymentUploadSectionState();
}

class _PaymentUploadSectionState extends State<PaymentUploadSection> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  /// Handles image selection from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile == null) {
        debugPrint("Image selection canceled.");
        return;
      }

      final File selectedImage = File(pickedFile.path);

      if (mounted) {
        setState(() {
          _imageFile = selectedImage;
        });
        widget.onImageSelected(selectedImage); // ✅ Pass File, not MultipartFile
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
    }
  }

  /// Shows bottom sheet for selecting camera or gallery
  void _showImagePickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              _buildPickerOption(
                icon: Icons.camera_alt,
                label: 'Take a Photo',
                source: ImageSource.camera,
              ),
              _buildPickerOption(
                icon: Icons.photo_library,
                label: 'Choose from Gallery',
                source: ImageSource.gallery,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Builds individual picker option
  Widget _buildPickerOption({required IconData icon, required String label, required ImageSource source}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: () {
        Navigator.pop(context);
        _pickImage(source);
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
        _buildUploadContainer(),
      ],
    );
  }

  /// Builds the upload container UI
  Widget _buildUploadContainer() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: ColorManager.backgroundLightPink,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Center(
        child: Column(
          children: [
            _imageFile != null
                ? Image.file(_imageFile!, height: 100.h, width: 100.w, fit: BoxFit.cover)
                : SvgPicture.asset(ImageManager.upload, height: 80.h, width: 80.w, fit: BoxFit.contain),
            TextButton(
              onPressed: _showImagePickerOptions,
              child: TitleWidget(title: AppString.upload),
            ),
          ],
        ),
      ),
    );
  }
}
