
import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
    final String name;
    final String phone;
    final String password;

    RegisterModel({
        required this.name,
        required this.phone,
        required this.password,
    });

    factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        name: json["name"],
        phone: json["phone"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "phone": phone,
        "password": password,
    };
}
