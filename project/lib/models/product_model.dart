class ProductModel {
  final int id;
  final String title;
  final String description;
  final double price;
  final String category;
  final String image;
  final Rating? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
    required this.image,
    this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "price": price,
      "category": category,
      "image": image,
      "rating": rating?.toMap(),
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map["id"],
      title: map["title"] ?? "",
      description: map["description"] ?? "",
      price: (map["price"] as num).toDouble(),
      category: map["category"] ?? "",
      image: map["image"] ?? "",
      rating: map["rating"] != null
          ? Rating.fromMap(map["rating"])
          : null,                    );
  }
}

class Rating {
  final double rate;
  final int count;

  Rating({required this.rate, required this.count});

  Map<String, dynamic> toMap() {
    return {
      "rate": rate,
      "count": count,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      rate: (map["rate"] as num).toDouble(),
      count: map["count"],
    );
  }
}
