import 'package:flutter/material.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class ProductsForOrder extends StatelessWidget {

  final List<dynamic> products;
  ProductsForOrder({
    required this.products,
});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
        title: 'Products For Order',
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
              itemBuilder:(context,index) => Card(
                child: Column(
                  children: [
                    Image(
                      image: NetworkImage('${products[index]['image']}'),
                      width: double.infinity,
                      height: 200.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultBodyText(context, text: '${products[index]['name']}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              defaultBodyText(context, text: ' currentPrice:${products[index]['currentPrice']}'),
                              Spacer(),
                              defaultBodyText(context, text: 'quantity:${products[index]['quantity']}'),
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
