import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class CustomProfileBackgroung extends StatefulWidget {
  const CustomProfileBackgroung({super.key});

  @override
  State<CustomProfileBackgroung> createState() =>
      _CustomProfileBackgroungState();
}

class _CustomProfileBackgroungState extends State<CustomProfileBackgroung> {
  File? _profileImage;

  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to capture image using the camera
  Future<void> _pickImageFromCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  // Function to display bottom sheet for selecting photo source
  void _showPhotoSourcePicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorManager.backgroundPinkColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Choose Profile Photo",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.darkGreyForFontColor,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: ColorManager.textRedColor,
                ),
                title: const Text(
                  "Pick from Gallery",
                  style: TextStyle(color: ColorManager.textRedColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt,
                  color: ColorManager.textRedColor,
                ),
                title: const Text(
                  "Take a Photo",
                  style: TextStyle(color: ColorManager.textRedColor),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImageFromCamera();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Pre-cache images to avoid flashing
    precacheImage(AssetImage(ImageManager.profileFrame), context);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(ImageManager.profileFrame),
        Column(
          children: [
            Stack(
              children: [
                // Profile image inside a circular border
                Container(
                  height: 150.h,
                  width: 150.w,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [
                          ColorManager.linearGradient1,
                          ColorManager.linearGradient2,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      )),
                  child: Center(
                    child: Container(
                      height: 140.h,
                      width: 140.w,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: _profileImage != null
                          ? Image.file(_profileImage!, fit: BoxFit.fill)
                          : Image.network(
                              'https://s3-alpha-sig.figma.com/img/e915/f882/38ac6007aa5be950081f8f386a727a10?Expires=1739145600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=hiBut43BEiezw7m5NASleNYmzS9ziNOyQwj14kS9CtjVkZGITJghYIRAldrTH1OyxwSXz22e8fgTtrRG3WJw71uOrpLM9-Wt9-6ock3dQLpCTqCCCXpDC~y6HSo1Ss9K1e7iWdCpdqA-omyk0LiafqJ4jQs4Ra~lEqnSX0bKrZM5x9t37F74rQPXbXdZG1B~yngERKh-1EKQOz97k3bid33Wa~HXvGu~PdrbC5Ac6-yR8KTc4CiHImZm2fcTlJIuXIPaCd115nsVC4NG8oeZNJUzC0i1us7Sb5A3ifygBZTgYqJwUeA9bXpxbVV5PSlxO2G8RrEcGcg-ElwdC6HJdA__'), // Replace with your image URL
                    ),
                  ),
                ),
                // Edit icon
                Positioned(
                  right: 0,
                  top: 0,
                  child: GestureDetector(
                    onTap: _showPhotoSourcePicker,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: ColorManager.backgroundPinkColor,
                      child: Icon(
                        Icons.edit,
                        color: ColorManager.textRedColor,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              'Jennifer James',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
