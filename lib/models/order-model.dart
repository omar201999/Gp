

class OrderModel{
  //String? orderId;
  String? userName;
  double? totalPrice;
  double? shipping;
  double? total;


  //List<ProductModel>? productsOfOrder = [] ;

  OrderModel({
    //this.orderId,
    this.userName,
    this.totalPrice,
    this.shipping,
    this.total,

    //this.productsOfOrder,
  });



  OrderModel.fromJson(Map<String, dynamic>? json) {
    //orderId = json!['orderId'];
    userName = json!['userName'];
    totalPrice = json['totalPrice'];
    shipping = json['shipping'];
    total = json['total'];

  }

  Map<String, dynamic> toMap()
  {
    return {
      //'orderId':orderId,
      'userName': userName,
      'totalPrice': totalPrice,
      'shipping': shipping,
      'total': total,

    };
  }

}


