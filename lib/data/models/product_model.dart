import 'dart:convert';

class ProductResponse {
  String? status;
  String? message;
  List<Products>? products;

  ProductResponse({this.status, this.message, this.products});

  
  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
      status: json['status'] as String?,
      message: json['message'] as String?,
      products: json['products'] != null
          ? List<Products>.from(
          json['products'].map((x) => Products.fromJson(x)))
          : null,
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'products': products?.map((p) => p.toJson()).toList(),
    };
  }
}

class Products {
  int? id;
  String? title;
  String? image;
  double? price;
  String? description;
  String? brand;
  String? model;
  String? color;
  String? category;
  int? discount;
  bool? popular;
  bool? onSale;

  Products({
    this.id,
    this.title,
    this.image,
    this.price,
    this.description,
    this.brand,
    this.model,
    this.color,
    this.category,
    this.discount,
    this.popular,
    this.onSale,
  });

  bool matchesQuery(String query) {
    final searchLower = query.toLowerCase();
    return (title?.toLowerCase().contains(searchLower) ?? false) ||
        (description?.toLowerCase().contains(searchLower) ?? false) ||
        (category?.toLowerCase().contains(searchLower) ?? false);
  }
  
  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      id: json['id'] as int?,
      title: json['title'] as String?,
      image: json['image'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      description: json['description'] as String?,
      brand: json['brand'] as String?,
      model: json['model'] as String?,
      color: json['color'] as String?,
      category: json['category'] as String?,
      discount: json['discount'] as int? ?? 0,
      popular: json['popular'] as bool? ?? false,
      onSale: json['onSale'] as bool? ?? false,
    );
  }

  
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
      'brand': brand,
      'model': model,
      'color': color,
      'category': category,
      'discount': discount,
      'popular': popular,
      'onSale': onSale,
    };
  }

  
  String toJsonString() {
    return jsonEncode({
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'description': description,
      'brand': brand,
      'model': model,
      'color': color,
      'category': category,
      'discount': discount,
      'popular': popular,
      'onSale': onSale,
    });
  }

  
  factory Products.fromJsonString(String jsonString) {
    final Map<String, dynamic> data = jsonDecode(jsonString);
    return Products(
      id: data['id'] as int?,
      title: data['title'] as String?,
      image: data['image'] as String?,
      price: (data['price'] as num?)?.toDouble(),
      description: data['description'] as String?,
      brand: data['brand'] as String?,
      model: data['model'] as String?,
      color: data['color'] as String?,
      category: data['category'] as String?,
      discount: data['discount'] as int? ?? 0,
      popular: data['popular'] as bool? ?? false,
      onSale: data['onSale'] as bool? ?? false,
    );
  }

  
  Products copyWith({
    int? id,
    String? title,
    String? image,
    double? price,
    String? description,
    String? brand,
    String? model,
    String? color,
    String? category,
    int? discount,
    bool? popular,
    bool? onSale,
  }) {
    return Products(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      description: description ?? this.description,
      brand: brand ?? this.brand,
      model: model ?? this.model,
      color: color ?? this.color,
      category: category ?? this.category,
      discount: discount ?? this.discount,
      popular: popular ?? this.popular,
      onSale: onSale ?? this.onSale,
    );
  }

  
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Products && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}