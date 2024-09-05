import 'dart:convert';

List<ProductResponse> productResponseFromJson(String str) => List<ProductResponse>.from(json.decode(str).map((x) => ProductResponse.fromJson(x)));

String productResponseToJson(List<ProductResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductResponse {
    final String id;
    final String name;
    final String description;
    final String image;
    final String categoryId;
    final String slug;
    final String price;

    ProductResponse({
        required this.id,
        required this.name,
        required this.description,
        required this.image,
        required this.categoryId,
        required this.slug,
        required this.price,
    });

    factory ProductResponse.fromJson(Map<String, dynamic> json) => ProductResponse(
        id: json["_id"],
        name: json["name"],
        description: json["description"] ?? "",
        image: json["image"] ?? "",
        categoryId: json["categoryId"],
        slug: json["slug"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "image": image,
        "categoryId": categoryId,
        "slug": slug,
        "price": price,
    };
}
