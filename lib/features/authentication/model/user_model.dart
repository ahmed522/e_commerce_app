import 'package:e_commerce_app/features/authentication/model/gender.dart';

class UserModel {
  String? status;
  String? message;
  UserData user = UserData();
  UserModel();
  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = UserData.fromJson(json['user']);
  }
  toJson() {
    Map<String, dynamic> json = {};
    json['user'] = user.toJson();
    json['status'] = status;
    json['message'] = message;
    return json;
  }
}

class UserData {
  String? name;
  String? email;
  String? phone;
  String? nationalId;
  String gender = Gender.male.name;
  String? token;
  String? profileImage;
  UserData();
  UserData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    nationalId = json['nationalId'];
    gender = json['gender'];
    token = json['token'];
    profileImage = json['profileImage'];
  }
  toJson() {
    Map<String, dynamic> json = {};
    json['name'] = name;
    json['email'] = email;
    json['phone'] = phone;
    json['nationalId'] = nationalId;
    json['gender'] = gender;
    json['profileImage'] = profileImage;
    if (token != null) {
      json['token'] = token;
    }
    return json;
  }
}
