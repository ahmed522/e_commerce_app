import 'package:e_commerce_app/features/profile/controller/profile_states.dart';
import 'package:e_commerce_app/features/profile/model/profile_model.dart';
import 'package:e_commerce_app/global/constants/api_constants.dart';
import 'package:e_commerce_app/global/services/cache_helper.dart';
import 'package:e_commerce_app/global/services/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitState());
  static ProfileCubit get(context) => BlocProvider.of(context);
  ProfileModel? profile;
  String? tempName;
  String? tempPhone;
  String? tempEmail;
  Future<void> fetchUserData() async {
    if (!isClosed) {
      emit(ProfileLoadingState());
    }
    DioHelper.postData(
        url: ApiConstants.profileApiUrl,
        data: {'token': await CacheHelper.getData(key: 'token')}).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(ProfileErrorState());
        }
      } else {
        if (value.data == null) {
          if (!isClosed) {
            emit(ProfileErrorState());
          }
        } else {
          if (!isClosed) {
            profile = ProfileModel.fromJson(value.data);
            emit(ProfileInitState());
          }
        }
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(ProfileErrorState());
        }
      },
    );
  }

  Future<void> updateUserData() async {
    if (!isClosed) {
      emit(ProfileLoadingState());
    }
    DioHelper.putData(
      url: ApiConstants.profileUpdateApiUrl,
      data: {
        'name': tempName ?? profile!.user!.name,
        'email': tempEmail ?? profile!.user!.email,
        'phone': tempPhone ?? profile!.user!.phone,
        'gender': 'male',
        'password': '1234567',
        'token': profile!.user!.token,
      },
    ).then((value) {
      if (value.data['status'] == 'error') {
        if (!isClosed) {
          emit(ProfileErrorState());
        }
      } else {
        if (!isClosed) {
          fetchUserData();
        }
      }
    }).catchError(
      (error) {
        if (!isClosed) {
          emit(ProfileErrorState());
        }
      },
    );
  }
}
