class CartModel{
  String? cartId;
  String? cartImage;
  String? cartName;
  int? cartPrice;
  int? quantity;

  CartModel({
    this.cartId,
    this.cartImage,
    this.cartName,
    this.cartPrice,
    this.quantity,

  });

  CartModel.fromJson(Map<String, dynamic>? json) {
    cartId = json!['cartId'];
    cartImage = json['cartImage'];

    cartName = json['cartName'];
    cartPrice = json['cartPrice'];
    quantity = json['quantity'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      'cartId':cartId,
      'cartName': cartName,
      'cartImage': cartImage,
      'cartPrice': cartPrice,
      'quantity': quantity,
    };
  }

}