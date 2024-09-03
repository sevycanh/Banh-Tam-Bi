import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    final String id;
    final bool isAdmin;
    final String address;
    final String userToken;

    LoginResponse({
        required this.id,
        required this.isAdmin,
        required this.address,
        required this.userToken,
    });

    factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        id: json["_id"],
        isAdmin: json["isAdmin"],
        address: json["address"]?? "",
        userToken: json["userToken"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "isAdmin": isAdmin,
        "address": address,
        "userToken": userToken,
    };
}
