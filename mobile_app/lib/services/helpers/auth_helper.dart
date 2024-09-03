import 'package:http/http.dart' as http;
import 'package:mobile_app/models/request/auth/login_model.dart';
import 'package:mobile_app/models/request/auth/register_model.dart';
import 'package:mobile_app/models/response/auth/login_res.dart';
import 'package:mobile_app/services/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper {
  static var client = http.Client();

  static Future<bool> login(LoginModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.loginUrl);
    var response = await client.post(url,
        headers: requestHeaders, body: loginModelToJson(model));
    if (response.statusCode == 200) {
      final SharedPreferences preferences =
          await SharedPreferences.getInstance();

      String token = loginResponseFromJson(response.body).userToken;
      String userId = loginResponseFromJson(response.body).id;
      String address = loginResponseFromJson(response.body).address;

      await preferences.setString('token', token);
      await preferences.setString('userId', userId);
      await preferences.setString('address', address);
      await preferences.setBool('loggedIn', true);

      return true;
    } else {
      return false;
    }
  }

  static Future<bool> register(RegisterModel model) async {
    Map<String, String> requestHeaders = {'Content-Type': 'application/json'};
    var url = Uri.http(Config.apiUrl, Config.registerUrl);
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: registerModelToJson(model),
    );

    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
