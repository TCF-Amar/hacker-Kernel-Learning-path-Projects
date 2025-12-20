class RatingModel {
  final double rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  Map<String, dynamic> toJson() {
    return {"rate": rate, "count": count};
  }

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: (json["rate"] ?? 0).toDouble(),
      count: json["count"] as int,
    );
  }
}
