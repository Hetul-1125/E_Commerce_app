import 'package:flutter/material.dart';
import 'package:vegi/models/productModel.dart';
import 'package:vegi/models/review_chary_model.dart';
class OrderItem extends StatelessWidget {
 ReviewChartModel?data;
 OrderItem({this.data});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("${data!.productname}"),
      leading: Image.network(data!.productimage!),
      trailing: Text("\$ ${data!.productprice}"),
      subtitle: Text("50 gram"),
    );;
  }
}

