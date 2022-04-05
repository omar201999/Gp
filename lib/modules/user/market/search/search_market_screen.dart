import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gp/layout/admin_layout/cubit/cubit.dart';
import 'package:gp/layout/admin_layout/cubit/states.dart';
import 'package:gp/models/product_model.dart';
import 'package:gp/modules/user/market/items/marketitem_screen.dart';
import 'package:gp/shared/componants/componants.dart';
import 'package:gp/shared/styles/colors.dart';
import 'package:gp/shared/styles/icon_broken.dart';

class SearchMarketingscreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    var searchController = TextEditingController();
    return BlocConsumer<AdminCubit,AdminStates>(
      listener: (context,state)
      {

      },
      builder: (context,state)
      {
        var list = AdminCubit.get(context).searchProduct;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon (IconBroken.Arrow___Left_2),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children:
              [
                defaultTextFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  onChanged: (value)
                  {
                    AdminCubit.get(context).getSearchProduct(value);

                  },

                  validate: (String? value)
                  {
                    if(value!.isEmpty)
                    {
                      return 'search must not be empty';

                    }
                    return null;

                  },
                  hintText: 'search',
                  prefix: IconBroken.Search,
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(

                  child: ConditionalBuilder(
                    condition:  list.length > 0,
                    builder: (context) => ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context,index) => buildProductSearchItem(list[index],context),
                        separatorBuilder: (context,index) =>  SizedBox(height: 8,),
                        itemCount: list.length),
                    fallback: (context) => Center(child: Container()),
                  ),
                ),



              ],
            ),
          ),

        );

      },

    );
  }
  Widget buildProductSearchItem(ProductModel model,context) => defaultGestureDetector(
    onTap: ()
    {
      navigateTo(context, MarketitemScreen(productModel: model,));
    },
    child: defaultContainer(
      color: constantColor5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage('${model.image}'),
                width: double.infinity,
                //height: 180.0,
                fit: BoxFit.cover,
              ),
              if (model.discount != 0)
                Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                        horizontal: 5.0
                    ),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,
                      ),
                    )
                ),
            ],
          ),
          Padding(
            padding: /*EdgeInsetsDirectional.only(
                start: 10,
            ),*/
            const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 6.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model.name}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.3,
                  ),
                ),
                Row(
                  children:
                  [
                    Text(
                      '${model.currentPrice}',
                      style: const TextStyle(
                        fontSize: 13.0,
                        color: defaultColor,
                      ),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    if (model.discount != 0)
                      Text(
                        '${model.oldPrice}',
                        style: const TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    ),
  );
}