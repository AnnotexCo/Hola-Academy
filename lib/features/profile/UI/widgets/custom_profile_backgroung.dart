import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hola_academy/core/local_db/save_token.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/core/constants/image_manager.dart';

class CustomProfileBackgroung extends StatefulWidget {
  File? profileImage;
  bool isEdit = false;
  CustomProfileBackgroung({super.key, this.profileImage, this.isEdit = false});

  @override
  State<CustomProfileBackgroung> createState() =>
      _CustomProfileBackgroungState();
}

class _CustomProfileBackgroungState extends State<CustomProfileBackgroung> {
  String? name;
  String? imageUrl;
  // Function to pick image from gallery
  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        widget.profileImage = File(pickedFile.path);
        BlocProvider.of<UserDataCubit>(context).profileImage = widget.profileImage;
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
        widget.profileImage = File(pickedFile.path);
        BlocProvider.of<UserDataCubit>(context).profileImage = widget.profileImage;
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
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    name = await SaveTokenDB.getName();
    imageUrl = await SaveTokenDB.getImagePath();
    setState(() {}); // Update UI after fetching data
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
                      child: widget.profileImage != null
                          ? Image.file(widget.profileImage!, fit: BoxFit.fill)
                          : CachedNetworkImage(
                              imageUrl:'https://s3-alpha-sig.figma.com/img/fd3d/4c48/a8b689cbbfb343fe22651fcb4dc1c2e0?Expires=1741564800&Key-Pair-Id=APKAQ4GOSFWCW27IBOMQ&Signature=tCNEsYxHOJniI5O7WcxTU27VdNZrPcgL~t~5TNQ5yKrsi1We703o81CmsG8uvS4HFVsfQ7Y9kV41rEXIbfijH3RO55nQiUdCkLa09XqCa2vstQ6nx6MNkqTiz~QyPcyyX9jy6a~UVj9rDI6-gu5ygfDsETEyJqkZMFEcZwcKhf8nMRRgG5cYTm9nnKEMZlqFJBBJZ2JfePJvfjv0EdEcRwakKoHjQz4~pvtI8k-t7uSjH38mVbUPUaZW6UpRmaDDdShg~1UypM6~HkNDtl7PVmEq0dSVNYDaa~6WVqecFfIV09AL0bZM3bbFNXD9UwEyttOHLWdnxH7AbI3h-c2N5g__',
                                  //imageUrl ?? widget.profileImage.toString(),
                              placeholder: (context, url) =>
                                  CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                ),
                // Edit icon
                if (widget.isEdit)
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
              name ?? 'No Name',
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
