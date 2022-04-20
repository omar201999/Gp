
class OrderModel{
  //String? orderId;
  String? userName;
  double? totalPrice;
  double? shipping;
  double? total;
  String? phone;
  String? address;


  OrderModel({
    //this.orderId,
    this.userName,
    this.totalPrice,
    this.shipping,
    this.total,
    this.address,
    this.phone,
  });



  OrderModel.fromJson(Map<String, dynamic>? json) {
    //orderId = json!['orderId'];
    userName = json!['userName'];
    totalPrice = json['totalPrice'];
    shipping = json['shipping'];
    total = json['total'];
    phone=json['phone'];
    address=json['address'];
  }

  Map<String, dynamic> toMap()
  {
    return {
      //'orderId':orderId,
      'userName': userName,
      'totalPrice': totalPrice,
      'shipping': shipping,
      'total': total,
      'phone': phone,
      'address': address,
    };
  }

}


