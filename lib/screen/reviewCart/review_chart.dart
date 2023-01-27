import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/models/review_chary_model.dart';
import 'package:vegi/providers/review_chat_provider.dart';
import 'package:vegi/screen/check_out/deliveryData.dart';

import '../widgets/singleitem.dart';

class ReviewScreen extends StatelessWidget {
  static const String id = 'reviewScreen';

  ReviewChartProvider? reviewChartProvider;

  showAlertDialog(BuildContext context, ReviewChartModel delet) {
    Widget cancelButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        reviewChartProvider!.reviewCartDatadelet(delet.productid);
        Navigator.of(context).pop();
      },
    );
    Widget continueButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    reviewChartProvider = Provider.of<ReviewChartProvider>(context);
    reviewChartProvider!.reviewProductData();

    return Scaffold(
        bottomNavigationBar: ListTile(
          title: Text('Total amount'),
          subtitle: Text('\$ ${reviewChartProvider!.getTotal()}'),
          trailing: MaterialButton(
            child: Text('Checkout'),
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DeliveryData()));
            },
          ),
        ),
        appBar: AppBar(
          title: Text('Review Chart'),
          backgroundColor: Colors.green,
        ),
        body: reviewChartProvider!.getreviewListData.isEmpty
            ? Center(
                child: Text("No Data"),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  ReviewChartModel data =
                      reviewChartProvider!.getreviewListData[index];
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
                        // isCount: false,
                        onDelet: () {
                          showAlertDialog(context, data);
                        },
                      )
                    ],
                  );
                },
                itemCount: reviewChartProvider!.getreviewListData.length,
              ));
  }
}
