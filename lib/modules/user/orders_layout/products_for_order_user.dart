import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/componants/constant.dart';
import 'package:gp/shared/cubit/cubit.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class ProductsForOrderUser extends StatelessWidget {

  final List<dynamic> products;
  final String orderNumber;
  ProductsForOrderUser({
    required this.products,
    required this.orderNumber
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Order number #$orderNumber',
        icon: IconBroken.Arrow___Left_2,
        onPressed: ()
        {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder:(context,index) => defaultContainer(
                  context,
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage('${products[index]['image']}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                      height: 250.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if(lan=='en')
                            defaultBodyText(context, text: 'Product name is ${products[index]['name']}'),
                          if(lan=='ar')
                            defaultBodyText(context, text: '${products[index]['nameAr']}'),
                          defaultBodyText(context, text: 'Price Per one : ${products[index]['currentPrice']}'),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultBodyText(context, text: ' Total : ${products[index]['currentPrice'] * products[index]['selectedQuantity'] }'),
                              Spacer(),
                              defaultBodyText(context, text: 'Quantity : ${products[index]['selectedQuantity']}'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              separatorBuilder: (context,index) => SizedBox(
                height: 10,
              ),
              itemCount:  products.length),
        ),
      )
    );
  }

}
