import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/features/profile/controller/profile_cubit.dart';
import 'package:e_commerce_app/features/profile/controller/profile_states.dart';
import 'package:e_commerce_app/features/profile/view/widgets/edit_data_dialog.dart';
import 'package:e_commerce_app/global/colors/app_colors.dart';
import 'package:e_commerce_app/global/fonts/app_fonts.dart';
import 'package:e_commerce_app/global/functions/common_functions.dart';
import 'package:e_commerce_app/global/widgets/app_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const String route = 'profileScreen';
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final cubit = ProfileCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (CommonFunctions.isLightMode(context))
            ? AppColors.primaryColor
            : AppColors.mediumColor,
        toolbarHeight: 0,
        elevation: 0,
        toolbarOpacity: 0.0,
      ),
      body: BlocBuilder<ProfileCubit, ProfileStates>(builder: (context, state) {
        if (state is ProfileLoadingState) {
          return SizedBox(
            width: size.width,
            height: size.height - 100,
            child: const Center(
              child: AppCircularProgressIndicator(
                height: 100,
                width: 100,
              ),
            ),
          );
        } else if (state is ProfileErrorState) {
          return CommonFunctions.internetError;
        }

        UserData user = cubit.profile!.user!;
        return SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const SizedBox(height: 200),
                  Container(
                    width: size.width,
                    height: 150,
                    decoration: BoxDecoration(
                      color: (CommonFunctions.isLightMode(context))
                          ? AppColors.primaryColor
                          : AppColors.mediumColor,
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                  ),
                  Positioned(
                    left: (size.width / 2),
                    bottom: 0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        user.profileImage!,
                      ),
                      radius: 60,
                    ),
                  ),
                  Positioned(
                    left: 5,
                    bottom: 0,
                    child: TextButton(
                      onPressed: () {
                        cubit.tempName = null;
                        showDialog(
                          context: context,
                          builder: (context) =>
                              BlocProvider<ProfileCubit>.value(
                            value: cubit,
                            child: EditDataDialog(name: user.name),
                          ),
                        );
                      },
                      child: Text(
                        user.name!,
                        style: const TextStyle(
                          fontFamily: AppFonts.englishFont1,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 80),
              ListTile(
                leading: const Icon(Icons.numbers_rounded),
                title: Text(
                  user.phone!,
                  style: const TextStyle(fontFamily: AppFonts.englishFont1),
                ),
                trailing: IconButton(
                  onPressed: () {
                    cubit.tempPhone = null;
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider<ProfileCubit>.value(
                        value: cubit,
                        child: EditDataDialog(phone: user.phone),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_rounded),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.email),
                title: Text(
                  user.email!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                trailing: IconButton(
                  onPressed: () {
                    cubit.tempEmail = null;
                    showDialog(
                      context: context,
                      builder: (context) => BlocProvider<ProfileCubit>.value(
                        value: cubit,
                        child: EditDataDialog(email: user.email),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit_rounded),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        );
      }),
    );
  }
}
