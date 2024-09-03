
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    final String phone;
    final String password;

    LoginModel({
        required this.phone,
        required this.password,
    });

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        phone: json["phone"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "phone": phone,
        "password": password,
    };
}