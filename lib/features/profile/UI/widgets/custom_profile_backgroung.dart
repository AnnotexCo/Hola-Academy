import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class CustomProfileBackgroung extends StatefulWidget {
  final bool isEdit;
  const CustomProfileBackgroung({
    super.key,
    this.isEdit = false,
  });

  @override
  State<CustomProfileBackgroung> createState() =>
      _CustomProfileBackgroungState();
}

class _CustomProfileBackgroungState extends State<CustomProfileBackgroung> {
  // Function to pick image from gallery
  

  // Function to display bottom sheet for selecting photo source
  void showPhotoSourcePicker(
      {required BuildContext context,
      void Function()? pickImageFromGallery,
      void Function()? pickImageFromCamera}) {
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
                onTap: pickImageFromGallery,
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
                onTap: pickImageFromCamera,
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
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataCubit, UserDataState>(
      builder: (context, state) {
        String name = " ";
        String pic = '';
        if (state is UserDataSuccess) {
          name = state.userModel.name??'';
          pic = state.userModel.profileImage?.path ?? '';
        }
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
                          child: context.read<UserDataCubit>().profileImage == null &&
                                  pic.isEmpty
                              ? Container()
                              : context.read<UserDataCubit>().profileImage != null
                                  ? Image.file(context.read<UserDataCubit>().profileImage!,
                                      fit: BoxFit.fill)
                                  : Image.network(
                                      ApiConstants.imagesURLApi + pic,
                                      fit: BoxFit.fill),
                          /*CachedNetworkImage(
                                  imageUrl: 
                                  imageUrl ?? widget.profileImage.toString(),
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.fill,
                                ),*/
                        ),
                      ),
                    ),
                    // Edit icon
                    if (widget.isEdit)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () => showPhotoSourcePicker(
                            pickImageFromGallery: () {
                  Navigator.pop(context);
                  context.read<UserDataCubit>().pickImageFromGallery();
                },
                pickImageFromCamera: () {
                  Navigator.pop(context);
                  context.read<UserDataCubit>().pickImageFromCamera();
                }, context: context),
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
                  name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
