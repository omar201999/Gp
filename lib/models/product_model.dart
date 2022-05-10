class ProductModel{
  String? name;
  String? nameAr;
  String? image;
  String? description;
  String? descriptionAr;
  double? currentPrice;
  double? oldPrice;
  double? discount;
  int? quantity;
  int? selectedQuantity;
  String? status;

  //String? uId;

  ProductModel({
    this.name,
    this.image,
    this.description,
    this.currentPrice,
    this.oldPrice,
    this.discount,
    this.quantity,
    this.selectedQuantity,
    this.status,
    this.nameAr,
    this.descriptionAr

    //this.uId,
  });

  ProductModel.fromJson(Map<String, dynamic>? json) {
    //uId = json['uId'];
    name = json!['name'];
    image = json['image'];
    description = json['description'];
    currentPrice = json['currentPrice'];
    oldPrice = json['oldPrice'];
    discount = json['discount'];
    status = json['status'];
    quantity = json['quantity'];
    selectedQuantity = json['selectedQuantity'];
    nameAr = json['nameAr'];
    descriptionAr = json['descriptionAr'];



  }

  Map<String, dynamic> toMap()
  {
    return {
      //'uId': uId,
      'name': name,
      'image': image,
      'description':description,
      'currentPrice': currentPrice,
      'oldPrice': oldPrice,
      'discount': discount,
      'status': status,
      'quantity': quantity,
      'selectedQuantity': selectedQuantity,
      'nameAr':nameAr,
      'descriptionAr':descriptionAr,

    };
  }

}