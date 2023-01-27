import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/wishlist_provider.dart';

import '../../models/review_chary_model.dart';
import '../widgets/singleitem.dart';
class WhishlistScreen extends StatefulWidget {
  const WhishlistScreen({Key? key}) : super(key: key);

  @override
  State<WhishlistScreen> createState() => _WhishlistScreenState();
}

class _WhishlistScreenState extends State<WhishlistScreen> {
  @override
  WhishlistProvider? whishlistProvider;



  @override
  Widget build(BuildContext context) {
    whishlistProvider=Provider.of<WhishlistProvider>(context);
    whishlistProvider!.WhishlistData();

    return Scaffold(
        appBar: AppBar(
          title: Text('Whishlist'),
          backgroundColor: Colors.green,
        ),
        body: whishlistProvider!.getWhishlistData.isEmpty
            ? Center(
          child: Text("No Data"),
        )
            : ListView.builder(
          itemBuilder: (context, index) {
            ReviewChartModel data = whishlistProvider!.getWhishlistData[index];
            return Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                SingleItem(
                  image: data.productimage,
                  price: data.productprice.toString(),
                  isBool: true,
                  name: data.productname,
                  quntity: data.quantity,
                  productid: data.productid,
                  isCount: false,
                   onDelet: (){
                    whishlistProvider!.whishlistDeletData(data.productid);
                   },
                )
              ],
            );
          },
          itemCount: whishlistProvider!.getWhishlistData.length,
        ));
  }
}
