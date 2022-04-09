class ProductModel{
  String? name;
  String? image;
  String? description;
  double? currentPrice;
  double? oldPrice;
  double? discount;
  int? quantity;
  String? status;
  String? uId;

  ProductModel({
    this.name,
    this.image,
    this.description,
    this.currentPrice,
    this.oldPrice,
    this.discount,
    this.quantity,
    this.status,
    this.uId
  });

  ProductModel.fromJson(Map<String, dynamic>? json) {
    uId = json!['uId'];
    name = json['name'];
    image = json['image'];
    description = json['description'];
    currentPrice = json['currentPrice'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    status = json['status'];
    quantity = json['quantity'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'uId': uId,
      'name': name,
      'image': image,
      'description':description,
      'currentPrice': currentPrice,
      'oldPrice': oldPrice,
      'discount': discount,
      'status': status,
      'quantity': quantity,
    };
  }

}