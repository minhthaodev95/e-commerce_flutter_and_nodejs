class Product {
  final String title;
  final String description;
  final String image;
  final double price;
  final String id;
  final String userName;
  final String userId;
  final DateTime dateCreated;

  Product({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.id,
    required this.userName,
    required this.userId,
    required this.dateCreated,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json["title"].toString(),
      description: json["description"].toString(),
      image: json["image"].toString(),
      price: json["price"].toDouble(),
      id: json["id"].toString(),
      userName: json["userName"].toString(),
      userId: json["userId"].toString(),
      dateCreated: DateTime.parse(json["dateCreated"]),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "title": title,
      "description": description,
      "image": image,
      "price": price,
      "id": id,
      "userName": userName,
      "userId": userId,
      "dateCreated": dateCreated.toIso8601String(),
    };
  }
}
