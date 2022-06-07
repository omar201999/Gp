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
  num? totalRating;
  num? numOfRates;
  num? averageRating;
  //bool? isFavorite;
  //String? userId;



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
    this.descriptionAr,
    this.totalRating,
    this.numOfRates,
    this.averageRating,
    //this.isFavorite,
    //this.userId,


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
    totalRating=json['totalRating'];
    numOfRates=json['numOfRates'];
    averageRating=json['averageRating'];
    //isFavorite=json['isFavorite'];
    //userId=json['userId'];



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
      'totalRating' :totalRating,
      'numOfRates' :numOfRates,
      'averageRating' :averageRating,
      //'isFavorite' :isFavorite,
      //'userId' :userId,

    };
  }

}