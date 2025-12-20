import 'package:project_1/models/rating_model.dart';
import 'package:uuid/uuid.dart';

/*
* ProductModel class is used to store the product data
* The class is used to parse the json data
*/
class ProductModel {
  final String id;
  final String title;
  final String description;
  final double price;
  final String category;
  final bool? bestSeller;

  final String image;
  final RatingModel rating;

  /*
  * ProductModel constructor is used to initialize the object
  */
  ProductModel({
    String? id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.category,
    required this.bestSeller,
  }) : id = id ?? const Uuid().v4();

  /*
  * toJson function is used to convert the object to json
  */
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "category": category,
      "price": price,
      "image": image,
      "bestSeller": bestSeller,
      "rating": rating.toJson(),
    };
  }

  /*
  * fromJson function is used to convert the json to object
  */
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString(),
      title: json['title'] ?? '',
      description: json['description'] ?? "",
      category: json['category'] ?? "",
      price: (json['price'] ?? 0).toDouble(),
      image: json['image'] ?? "",
      rating: RatingModel.fromJson(json['rating']),
      bestSeller: json['bestSeller'] ?? false,
    );
  }
}
