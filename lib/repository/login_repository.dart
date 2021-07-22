import 'dart:convert';

import 'package:mcn_app/constants/constants.dart';
import 'package:mcn_app/models/response/api_response.dart';
import 'package:mcn_app/models/user.dart';
import 'package:mcn_app/repository/base/base_repository.dart';
import '../data/hive_helper.dart';

class LoginRepository extends BaseRepository {
  Future<User> login(String email, String password) async {
    Map<String, String> queryParams = {"email": email.trim(), "password": password};
    ApiResponse response = await postApi(API.loginUrl, queryParams);
    if (checkError(response)) {
      throw response.message ?? "Cannot Login";
    }
    //todo parse according to data
    User user = User.fromJson(response.data["user"]);
    await HiveHelper.putString(PrefKeys.userKey, jsonEncode(user.toJson()));
    return user;
  }

  User? isLoggedIn() {
    String? userJson = HiveHelper.getString(PrefKeys.userKey);
    if (userJson == null) return null;
    return User.fromJson(jsonDecode(userJson));
  }
}
