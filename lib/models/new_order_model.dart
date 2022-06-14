class NewOrderModel
{
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
  String? status;
  int? quantity;
  int? month;
  //List<ProductModel>? cardItemList;
  List<dynamic>? cardItemList;
  NewOrderModel({
    this.orderId,
    this.userName,
    this.totalPrice,
    this.shipping,
    this.total,
    this.address,
    this.phone,
    this.dateTime,
    this.cardItemList,
    this.quantity,
    this.productName,
    this.status,
    this.userEmail,
    this.orderNumber,
    this.productNameAr,
    this.month,
  });

  NewOrderModel.fromJson(Map<String, dynamic>? json)
  {
    orderId = json!['orderId'];
    userName = json['userName'];
    totalPrice = json['totalPrice'];
    shipping = json['shipping'];
    total = json['total'];
    phone=json['phone'];
    address=json['address'];
    dateTime=json['dateTime'];
    /* json['cardItemList'].forEach((element) {
      cardItemList?.add(ProductModel.fromJson(element));
    });*/
    cardItemList=json['cardItemList'];
    /* List<dynamic> temp = json['cardItemList'] as List<dynamic>;
    cardItemList?.addAll(temp.map((e) => ProductModel.fromJson(e)).toList());*/
    quantity=json['quantity'];
    productName=json['productName'];
    status=json['status'];
    userEmail=json['userEmail'];
    orderNumber=json['orderNumber'];
    productNameAr=json['productNameAr'];
    month = json['month'];
  }
  Map<String, dynamic> toMap()
  {
    return {
      'orderId':orderId,
      'userName': userName,
      'totalPrice': totalPrice,
      'shipping': shipping,
      'total': total,
      'phone': phone,
      'address': address,
      'dateTime': dateTime,
      'status': status,
      'productName': productName,
      'quantity': quantity,
      'userEmail': userEmail,
      'orderNumber': orderNumber,
      'productNameAr': productNameAr,
      'cardItemList' : cardItemList?.map((e) => e.toMap()).toList(),//ProductModel?? []
      'month' : DateTime.now().month,
    };
  }
}

/* String? name;
    String? image;
    String? description;
    double? currentPrice;
    double? oldPrice;
    double? discount;
    int? quantity;
    String? status;
    String? uId;*/