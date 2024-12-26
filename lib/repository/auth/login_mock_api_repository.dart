

import 'package:bloc_clean_coding/model/user/user_model.dart';
import 'package:bloc_clean_coding/repository/auth/login_repository.dart';

class LoginMockApiRepository implements LoginRepository {

  @override
  Future<UserModel> loginApi(dynamic data) async {
   await Future.delayed(const Duration(seconds: 3));
   final response = {
     'token' : '4567890'
   };
    return UserModel.fromJson(response);

  }

}