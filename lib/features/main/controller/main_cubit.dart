import 'package:e_commerce_app/features/authentication/model/user_model.dart';
import 'package:e_commerce_app/features/main/controller/main_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainCubit extends Cubit<MainStates> {
  MainCubit(this.user) : super(MainInitState());
  static MainCubit get(context) => BlocProvider.of(context);
  final UserData user;
}
