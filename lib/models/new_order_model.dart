class NewOrderModel
{
  String? orderId;
  String? userName;
  double? totalPrice;
  double? shipping;
  double? total;
  String? phone;
  String? address;
  String? dateTime;
  String? productName;
  String? status;
  int? quantity;
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
      'cardItemList' : cardItemList?.map((e) => e.toMap()).toList(),//ProductModel?? []
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