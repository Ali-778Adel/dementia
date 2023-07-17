import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:time_control/presentation/pages/settings/blocs/profile_bloc/profile_bloc.dart';
import 'package:time_control/presentation/pages/settings/blocs/profile_bloc/profile_events.dart';
import 'package:time_control/presentation/pages/settings/blocs/profile_bloc/profile_states.dart';
import 'package:time_control/presentation/resources/palette.dart';
import 'package:sizer/sizer.dart';
import '../../../core/localization/strings.dart';
import '../../../di/dependency-injection.dart';
import '../../global_widgets/loading.dart';
import '../../global_widgets/my_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
          appBarTitle: Strings.of(context)!.profile,
          isSubWidget: true,
          onTabBack: () {
            Navigator.pop(context);
          }).call(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<ProfileBloc>()..add(GetProfileDataEvent()),
        child:
            BlocBuilder<ProfileBloc, ProfileStates>(builder: (context, state) {
          if (state is GetProfileDataState) {
            switch (state.profileStatus) {
              case ProfileStatus.loading:
                {
                  return const Loading();
                }
              case ProfileStatus.failure:
                {
                  return const Text(
                      'it seems that we lost your data please login again');
                }
              case ProfileStatus.success:
                {
                  return _buildBodyContent(context, state);
                }
              default:
                {
                  return const Text('unexpected error occured');
                }
            }
          }
          return const Text('unexpected error occured');
        }));
  }

  Widget _buildBodyContent(BuildContext context, GetProfileDataState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildProfileImageItem(context, state),
          SizedBox(
            height: 5.h,
          ),
          _buildDataContainer(
              context,
              Icons.title,
              Strings.of(context)!.userName,
              state.userModel!.userName ?? 'user name'),
          _buildDataContainer(context, Icons.email_outlined,
              Strings.of(context)!.email, '${state.userModel!.email}'),
          _buildDataContainer(
              context,
              Icons.phone,
              Strings.of(context)!.phoneNumber,
              state.userModel!.phoneNumber ?? 'phone number'),
        ],
      ),
    );
  }

  Widget _buildProfileImageItem(
      BuildContext context, GetProfileDataState state) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 150.sp,
          width: 150.sp,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                  color: Palette.lightGrey,
                  offset: Offset(10.0, 10.0),
                  blurRadius: 10,
                  blurStyle: BlurStyle.inner),
              BoxShadow(
                  color: Palette.lightGrey,
                  offset: Offset(-10.0, 10.0),
                  blurRadius: 5,
                  blurStyle: BlurStyle.inner),
            ],
            // borderRadius: BorderRadius.all(Radius.circular(100.sp)),
            border: Border.all(color: Palette.primary),
          ),
          child: CachedNetworkImage(
            imageUrl: "${state.userModel!.photoUrl}",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            placeholder: (context, url) => const Loading(),
            errorWidget: (context, url, error) => const Icon(Icons.error),
          ),
        ),
        Positioned(
            bottom: 150.sp / 5,
            right: -10.0,
            child: InkWell(
              child: Container(
                height: 30.sp,
                width: 30.sp,
                decoration: BoxDecoration(
                  color: Palette.primary,
                  borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                  border: Border.all(color: Palette.primary),
                ),
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ),
            )),
      ],
    );
  }

  Widget _buildDataContainer(
      BuildContext context, IconData iconsData, String title, String subTitle) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.sp, horizontal: 8.sp),
      margin: EdgeInsets.only(top: 8.sp),
      height: 60.sp,
      decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Palette.hint))),
      child: ListTile(
        leading: Icon(iconsData),
        title: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Palette.hint),
        ),
        subtitle: Text(
          subTitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
