
class OrderModel{
  String? orderId;
  String? orderNumber;
  String? userName;
  String? userEmail;
  double? totalPrice;
  double? shipping;
  double? total;
  String? phone;
  String? address;
  String? dateTime;
  String? productName;
  String? productNameAr;
  int? quantity;
  String? status;





  OrderModel({
    this.orderId,
    this.orderNumber,
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
    this.userEmail,
    this.productNameAr,


  });



  OrderModel.fromJson(Map<String, dynamic>? json) {
    orderId = json!['orderId'];
    orderNumber = json['orderNumber'];
    userName = json['userName'];
    totalPrice = json['totalPrice'];
    shipping = json['shipping'];
    total = json['total'];
    phone=json['phone'];
    address=json['address'];
    dateTime=json['dateTime'];
    productName=json['productName'];
    quantity = json['quantity'];
    status = json['status'];
    userEmail = json['userEmail'];
    productNameAr = json['productNameAr'];


  }

  Map<String, dynamic> toMap()
  {
    return {
      'orderId':orderId,
      'orderNumber':orderNumber,
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
      'userEmail': userEmail,
      'productNameAr': productNameAr,
    };
  }

}


