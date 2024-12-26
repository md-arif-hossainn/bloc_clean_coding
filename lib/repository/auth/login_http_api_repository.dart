

import 'package:bloc_clean_coding/config/app_url.dart';
import 'package:bloc_clean_coding/data/network/network_api_services.dart';
import 'package:bloc_clean_coding/model/user/user_model.dart';
import 'package:bloc_clean_coding/repository/auth/login_repository.dart';

class LoginHttpApiRepository implements LoginRepository {

  final api = NetworkApiService();

  @override
  Future<UserModel> loginApi(dynamic data) async {
    final response = await api.postApi(AppUrl.loginEndPint, data);
    print('-------------------$response');
    return UserModel.fromJson(response);

  }

}