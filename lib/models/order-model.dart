
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
  int? quantity;
  String? status;





  OrderModel({
    //this.orderId,
    this.userName,
    this.totalPrice,
    this.shipping,
    this.total,
    this.address,
    this.phone,
    this.dateTime,
    this.productName,
    this.quantity,
    this.status,


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
    quantity = json['quantity'];
    status = json['status'];


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
      'quantity': quantity,
      'status': status,



    };
  }

}


