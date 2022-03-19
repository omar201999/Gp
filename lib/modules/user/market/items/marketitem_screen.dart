import 'package:flutter/material.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/models/recipes_model.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
class MarketitemScreen extends StatelessWidget {
  late ProductModel productModel;
  MarketitemScreen({
    required this.productModel,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          children:
          [
            Stack(
              children:
              [
                Container(
                  width: double.infinity,
                  height: 350,
                  decoration:  BoxDecoration(
                    image: DecorationImage(
                      image:NetworkImage('${productModel.image}'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                      top: 30
                  ),
                  child: IconButton(
                    color: Colors.white,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon( Icons.arrow_back, ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:
                [
                  defaultContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          defaultHeadLineText(
                              context,
                              text: '${productModel.name}',
                              maxLines: 2
                          ),
                        ],
                      ),
                    ),
                    width: double.infinity,
                    height: 100,
                  ),
                  const SizedBox(height: 15,),

                  defaultContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          defaultHeadLineText(
                              context, text: ''),
                          const SizedBox(height: 5,),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultContainer(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultHeadLineText(context, text: 'description'),
                            const SizedBox(height: 5,),
                            ListView.separated(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 5,
                                    start: 5
                                ),
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    defaultBodyText(context,
                                        text: '${productModel.description}'
                                    ),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 5,),
                                itemCount: 1
                            ),
                          ],
                        ),
                      )
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  defaultContainer(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            defaultHeadLineText(context, text: 'category'),
                            const SizedBox(height: 5,),
                            ListView.separated(
                                padding: const EdgeInsetsDirectional.only(
                                    top: 5,
                                    start: 5
                                ),
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, index) =>
                                    defaultBodyText(context,
                                      text: '${productModel.category}',
                                    ),
                                separatorBuilder: (context, index) =>
                                const SizedBox(height: 5,),
                                itemCount: 1
                            ),
                          ],
                        ),
                      )
                  ),


                ],
              ),
            ),
          ],
        ),
      ),

    );
  }
}
