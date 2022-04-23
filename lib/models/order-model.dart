
class OrderModel{
  //String? orderId;
  String? userName;
  double? totalPrice;
  double? shipping;
  double? total;
  String? phone;
  String? address;
  String? dateTime;
  String? productName;




  OrderModel({
    //this.orderId,
    this.userName,
    this.totalPrice,
    this.shipping,
    this.total,
    this.address,
    this.phone,
    this.dateTime,
    this.productName
  });



  OrderModel.fromJson(Map<String, dynamic>? json) {
    //orderId = json!['orderId'];
    userName = json!['userName'];
    totalPrice = json['totalPrice'];
    shipping = json['shipping'];
    total = json['total'];
    phone=json['phone'];
    address=json['address'];
    dateTime=json['dateTime'];
    productName=json['productName'];

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
      'dateTime': dateTime,
      'productName': productName,


    };
  }

}


