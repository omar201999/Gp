

class OrderModel{
  //String? orderId;
  String? userId;
  double? totalPrice;
  double? shipping;
  double? total;


  //List<ProductModel>? productsOfOrder = [] ;

  OrderModel({
    //this.orderId,
    this.userId,
    this.totalPrice,
    this.shipping,
    this.total,

    //this.productsOfOrder,
  });



  OrderModel.fromJson(Map<String, dynamic>? json) {
    //orderId = json!['orderId'];
    userId = json!['userId'];
    totalPrice = json['totalPrice'];
    shipping = json['shipping'];
    total = json['total'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      //'orderId':orderId,
      'userId': userId,
      'totalPrice': totalPrice,
      'shipping': shipping,
      'total': total,

    };
  }

}


