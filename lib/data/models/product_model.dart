class product {
  String? status;
  String? message;
  List<Products>? products;

  product({this.status, this.message, this.products});

  product.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  int? id;
  String? title;
  String? image;
  int? price;
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

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    price = json['price'];
      description = json['description'];
    brand = json['brand'];
    model = json['model'];
    color = json['color'];
    category = json['category'];
    discount = json['discount'];
    popular = json['popular'];
    onSale = json['onSale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image'] = image;
    data['price'] = price;
    data['description'] = description;
    data['brand'] = brand;
    data['model'] = model;
    data['color'] = color;
    data['category'] = category;
    data['discount'] = discount;
    data['popular'] = popular;
    data['onSale'] = onSale;
    return data;
  }
}

