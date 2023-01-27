import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/review_chat_provider.dart';
import 'package:vegi/screen/widgets/count.dart';
import 'package:vegi/screen/widgets/unitdata.dart';

class SingleItem extends StatefulWidget {
  bool? isBool = false;
  String? image;
  String? name;
  String? price;
  int? quntity;
  String? productid;
  void Function()? onDelet;
  bool? isCount;
  // bool?isCount;
  SingleItem(
      {this.isBool,
      this.price,
      this.name,
      this.image,
      this.productid,
      this.quntity,
      this.onDelet,
      this.isCount});

  @override
  State<SingleItem> createState() => _SingleItemState();
}

class _SingleItemState extends State<SingleItem> {
  int? count;
  getcount() {
    setState(() {
      count = widget.quntity;
    });
  }

  ReviewChartProvider? reviewChartProvider;

  @override
  Widget build(BuildContext context) {
    getcount();
    reviewChartProvider = Provider.of<ReviewChartProvider>(context);
    reviewChartProvider!.reviewProductData();
    // print(count);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 100,
          width: 100,
          child: Image.network(widget.image!),
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          height: 130,
          width: 100,
          // color: Colors.green,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.name!),
              Text(
                "${widget.price}\$",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(
                height: 3,
              ),
              widget.isBool == true
                  ? Text('50 gram')
                  : Unitdata(
                      title: "50 gram",
                      onTap: () {
                        showModalBottomSheet(
                            backgroundColor: Colors.green[100],
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    title: new Text('50 gram'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    title: new Text('500 gram'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  Divider(
                                    height: 1,
                                  ),
                                  ListTile(
                                    title: new Text('1 Kg'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            });
                      },
                    ),
            ],
          ),
        ),
        widget.isBool == true
            ? widget.isCount == false
                ? IconButton(
                    onPressed: widget.onDelet,
                    icon: Icon(Icons.delete_outline_outlined),
                  )
                : Container(
                    margin: EdgeInsets.only(right: 20),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: widget.onDelet,
                            icon: Icon(Icons.delete_outline_outlined),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                              height: 33,
                              width: 70,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Row(
                                // crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (count == 1) {
                                        Fluttertoast.showToast(
                                            msg: "You reach minimum limit");
                                      } else {
                                        setState(() {
                                          count = count! - 1;
                                        });
                                      }
                                      reviewChartProvider!
                                          .updateReviewChartData(
                                        productprice:
                                            int.tryParse(widget.price!),
                                        productname: widget.name,
                                        productimage: widget.image,
                                        productid: widget.productid,
                                        quantity: count,
                                      );
                                    },
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                  Text(
                                    '${count}',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (count! > 9) {
                                        Fluttertoast.showToast(
                                            msg: "You reached maximum list");
                                      } else {
                                        setState(() {
                                          count = count! + 1;
                                        });
                                      }
                                      reviewChartProvider!
                                          .updateReviewChartData(
                                        productprice:
                                            int.tryParse(widget.price!),
                                        productname: widget.name,
                                        productimage: widget.image,
                                        productid: widget.productid,
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
                              ))
                        ],
                      ),
                    ),
                  )
            : Count(
                productid: widget.productid,
                productimage: widget.image,
                productname: widget.name,
                productprice: int.parse(widget.price!),
              ),
      ],
    );
  }
}
