import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hola_academy/core/Routing/routes.dart';
import 'package:hola_academy/core/constants/api_constants.dart';
import 'package:hola_academy/core/constants/color_manager.dart';
import 'package:hola_academy/features/Admin/home/UI/loading/new_requests_shimmer.dart';
import 'package:hola_academy/features/Admin/requests/Logic/requests_cubit.dart';
import 'package:hola_academy/features/home/UI/components/profile_pic_widget.dart';
import 'package:hola_academy/features/home/UI/components/timeline_widget.dart';
import 'package:hola_academy/features/profile/Data/Model/trainee_model.dart';
import 'package:hola_academy/features/profile/Logic/personal_info/user_data_cubit.dart';
import '../../../../core/dependency_injection/dependency.dart';
import '../../../home/Logic/banner_logic/banner_cubit.dart';
import '../../../home/UI/components/add_baner.dart';
import 'widgets/new_requests_section.dart';
import 'widgets/section_header.dart';
import 'widgets/welcome_widget.dart';

class HomeAdminScreen extends StatefulWidget {
  const HomeAdminScreen({super.key});

  @override
  State<HomeAdminScreen> createState() => _HomeAdminScreenState();
}

class _HomeAdminScreenState extends State<HomeAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocProvider(
                  create: (context) => getIT<UserDataCubit>()..getMyData(),
                  child: WelcomeWidget(),
                ),
                SizedBox(height: 16.h),
                BlocProvider(
                  create: (context) => getIT<BannersCubit>()..fetchAllBanners(),
                  child: AddBaner(),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  height: 80.h,
                  width: double.infinity,
                  child: TimelineWidget(),
                ),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'New Requests',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context).pushNamed(Routes.requestsScreen);
                  },
                ),
                SizedBox(height: 16.h),
                BlocProvider(
                  create: (context) =>
                      getIT<RequestsCubit>()..fetchAllRequests(),
                  child: NewRequestsSection(),
                ),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Coaches',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context)
                        .pushNamed(Routes.traineesScreen, arguments: 'COACH');
                  },
                ),
                SizedBox(height: 16.h),
                BlocProvider(
                  create: (context) => getIT<UserDataCubit>()..fetchAllUsers(),
                  child: CoachesSection(
                    isCoach: true,
                  ),
                ),
                SizedBox(height: 24.h),
                SectionHeader(
                  title: 'Trainee',
                  action: 'View All',
                  onPressed: () {
                    // Navigate to the new requests screen
                    Navigator.of(context)
                        .pushNamed(Routes.traineesScreen, arguments: 'TRAINEE');
                  },
                ),
                SizedBox(height: 16.h),
                BlocProvider(
                  create: (context) => getIT<UserDataCubit>(),
                  child: CoachesSection(
                    isCoach: false,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CoachesSection extends StatefulWidget {
  final bool isCoach;
  const CoachesSection({super.key, required this.isCoach});

  @override
  State<CoachesSection> createState() => _CoachesSectionState();
}

class _CoachesSectionState extends State<CoachesSection> {
  @override
  void initState() {
    super.initState();
    context.read<UserDataCubit>().fetchAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserDataCubit, UserDataState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              childAspectRatio: 1.2, // Adjusted for better layout proportions
            ),
            itemCount: 2,
            itemBuilder: (context, index) {
              List<User> users = widget.isCoach
                  ? context.read<UserDataCubit>().coaches
                  : context.read<UserDataCubit>().trainees;

              return users.isEmpty
                  ? NewRequestsShimmer()
                  : CoachCard(
                      name: users[index].name ?? '',
                      phoneNumber: users[index].phoneNumber ?? '',
                      pic: users[index].profileImage?.path ?? '');
            });
      },
    );
  }
}

class CoachCard extends StatelessWidget {
  final String name;
  final String phoneNumber;
  final String pic;

  const CoachCard(
      {super.key,
      required this.name,
      required this.phoneNumber,
      required this.pic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 194.w,
      height: 126.h,
      decoration: BoxDecoration(
        color: ColorManager.lightYellow, // Light orange background
        border: Border.all(
          color: ColorManager.primaryOrangeColor, // Border color
          width: 1.w,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.only(left: 7.w),
      child: Column(
        spacing: 8.h,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circle Avatar
          Center(
              child: SizedBox(
            height: 60.h,
            width: 60.w,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: '${ApiConstants.imagesURLApi}$pic',
                fit: BoxFit.cover,
                placeholder: (context, ur0l) => ShimmerCircle(size: 50.w),
                errorWidget: (context, url, error) => CircleAvatar(
                  backgroundColor: ColorManager.lightYellow,
                  child:
                      const Icon(Icons.person, color: Colors.white, size: 30),
                ),
              ),
            ),
          )),
          SizedBox(height: 12.h),
          // Name
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'Name: ',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: ColorManager.primaryOrangeColor, // Orange text color
              ),
              children: [
                TextSpan(
                  text: name,
                  style: TextStyle(
                    // fontFamily: 'Poppins',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.whiteColor, // Orange text color
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          // Phone Number
          RichText(
            textAlign: TextAlign.left,
            text: TextSpan(
              text: 'Phone Number: ',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFA500), // Orange text color
              ),
              children: [
                TextSpan(
                  text: phoneNumber,
                  style: TextStyle(
                    // fontFamily: 'Poppins',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorManager.whiteColor, // Orange text color
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
