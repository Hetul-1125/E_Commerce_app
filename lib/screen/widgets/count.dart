import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/review_chat_provider.dart';

class Count extends StatefulWidget {
  String? productname;
  String? productimage;
  String? productid;
  int? productprice;
  int?productquantity;
  Count(
      {this.productid, this.productprice, this.productimage, this.productname,this.productquantity});

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  ReviewChartProvider? reviewChartProvider;
  bool isbool = false;
  int count = 1;
  getAddQuantity() {
    FirebaseFirestore.instance
        .collection("reviewchardata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourreviewchartdata").doc(widget.productid)
        .get().then((value) {
          if(mounted)
            {

              if(value.exists)
              {
                setState(() {
                  count=value.get("productquantity");
                  isbool=value.get("isAdd");
                });
              }
            }
    });
  }

  @override
  Widget build(BuildContext context) {
    getAddQuantity();
    ReviewChartProvider reviewChartProvider = Provider.of(context);
    return Container(
      height: 33,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: Colors.grey),
      ),
      child: isbool == true
          ? Row(
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (count <= 1) {
                        isbool = false;
                        reviewChartProvider
                            .reviewCartDatadelet(widget.productid);
                      } else {
                        setState(() {
                          count--;
                        });

                        reviewChartProvider.updateReviewChartData(
                          productid: widget.productid,
                          productimage: widget.productimage,
                          productname: widget.productname,
                          productprice: widget.productprice,
                          quantity: count,
                        );
                      }
                    });
                  },
                  child: Icon(
                    Icons.remove,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Text(
                  '$count',
                  style: TextStyle(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      count++;
                    });
                    reviewChartProvider.updateReviewChartData(
                      productid: widget.productid,
                      productimage: widget.productimage,
                      productname: widget.productname,
                      productprice: widget.productprice,
                      quantity: count,
                    );
                  },
                  child: Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            )
          : Center(
              child: InkWell(
                  onTap: () {
                    setState(() {
                      isbool = true;
                    });
                    reviewChartProvider.addReviewChartData(
                      productid: widget.productid,
                      productimage: widget.productimage,
                      productname: widget.productname,
                      productprice: widget.productprice,
                      quantity: count,
                    );
                  },
                  child: Text(
                    'ADD',
                    style: TextStyle(color: Colors.black),
                  )),
            ),
    );
  }
}
