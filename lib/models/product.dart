import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.slug,
    this.title,
    this.description,
    this.price,
    this.featuredImage,
    this.status,
    this.createdAt,
    this.quatity = 0,
    this.inCart = false,
  });

  int? id;
  String? slug;
  String? title;
  String? description;
  int? price;
  String? featuredImage;
  String? status;
  String? createdAt;
  int quatity = 0;
  bool inCart = false;

  Product.fromJson(dynamic json) {
    id = json['id'];
    slug = json['slug'];
    title = json['title'];
    description = json['description'];
    price = json['price'];
    featuredImage = json['featured_image'];
    status = json['status'];
    createdAt = json['created_at'];
    inCart = json['in_cart'] ?? false;
    quatity = json['quatity'] ?? 0;
  }

  Product copyWith({
    int? id,
    String? slug,
    String? title,
    String? description,
    int? price,
    String? featuredImage,
    String? status,
    String? createdAt,
  }) =>
      Product(
        id: id ?? this.id,
        slug: slug ?? this.slug,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        featuredImage: featuredImage ?? this.featuredImage,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['slug'] = slug;
    map['title'] = title;
    map['description'] = description;
    map['price'] = price;
    map['featured_image'] = featuredImage;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['in_cart'] = inCart;
    map['quatity'] = quatity;
    return map;
  }

  Product updateQuatity(int quatity) {
    return Product(
      createdAt: createdAt,
      description: description,
      featuredImage: featuredImage,
      id: id,
      inCart: true,
      price: price,
      quatity: quatity,
      slug: slug,
      status: status,
      title: title,
    );
  }
}
