
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
    this.cardItemList
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
    cardItemList=json['cardItemList'];

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
      'cardItemList' : cardItemList!.map((e) => e.toMap()).toList(),
    };
  }


}