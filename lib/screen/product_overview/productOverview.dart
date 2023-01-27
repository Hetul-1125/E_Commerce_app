import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/wishlist_provider.dart';
import 'package:vegi/screen/reviewCart/review_chart.dart';

import '../widgets/count.dart';

enum SinginCharacter { fill, outline }

class ProductOverview extends StatefulWidget {
  static const String id = 'productOverview';
  final String? name;
  final String? price;
  final String? imageurl;
  final int? quantity;
  final String? productid;
  final bool?isAdd;

  ProductOverview({this.price,this.imageurl,this.name,this.productid,this.isAdd,this.quantity});

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
 WhishlistProvider? whishlistProvider;
  SinginCharacter _character = SinginCharacter.fill;
  bool isAdd=false;
  Widget bottom({String? title, IconData? iconData, Color? bcolor}) {
    return Container(
      color: bcolor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              iconData,
              color: Colors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              title!,
              style: TextStyle(color: Colors.white, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    whishlistProvider=Provider.of<WhishlistProvider>(context);
    return Scaffold(
      bottomNavigationBar: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                setState(() {
                  isAdd=!isAdd;
                });
                if(isAdd==true)
                  {
                    whishlistProvider!.addwhishlistData(
                      whishlistid: widget.productid,
                      whishlistimage: widget.imageurl,
                      whishlistname: widget.name,
                      whishlistprice: int.tryParse(widget.price!),
                      isAdd: widget.isAdd,
                      quantity: widget.quantity,

                    );
                  }
                else{
                  whishlistProvider!.whishlistDeletData(widget.productid);
                }

              },
              child: bottom(
                title: "Add to Wishlist",
                bcolor: Colors.black,
                iconData:isAdd==true? Icons.favorite: Icons.favorite_outline,
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                Navigator.pushNamed(context,ReviewScreen.id);
              },
              child: bottom(
              title: "Go to cart",
              bcolor: Colors.green,
              iconData: Icons.shop_outlined,
          ),
            ), )

        ],
      ),
      appBar: AppBar(
        title: Text(
          "Product Overview",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(widget.name!),
                    subtitle: Text("${widget.price!}\$"),
                  ),
                  Container(
                    height: 250,
                    padding: EdgeInsets.all(40),
                    child: Image.network(widget.imageurl!),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Available Option"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: Colors.green,
                        ),
                        Radio(
                            value: SinginCharacter.fill,
                            groupValue: _character,
                            activeColor: Colors.green,
                            onChanged: (value) {
                              setState(() {
                                _character = value!;
                              });
                            }),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Text("${widget.price!}\$"),
                        ),
                        Count(
                          productid:widget.productid ,
                          productimage: widget.imageurl,
                          productname: widget.name,
                          productprice:int.parse(widget.price!),

                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("About the Product"),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}
