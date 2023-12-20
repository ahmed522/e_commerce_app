import 'package:e_commerce_app/features/authentication/model/user_model.dart';

class ProfileModel {
  String? status;
  String? msg;
  UserData? user;

  ProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['message'];
    user = UserData.fromJson(json['user']);
  }
}
