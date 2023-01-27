import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:vegi/screen/product_overview/productOverview.dart';
import 'package:vegi/screen/widgets/count.dart';
import 'package:vegi/screen/widgets/unitdata.dart';

import '../../models/productModel.dart';
import '../../providers/product_provider.dart';

class SingleProduct extends StatefulWidget {
  String? price;
  String? name;
  void Function()? oncall;
  String? imageurl;
  String?productid;
   List<dynamic>? productunit;
   SingleProduct({this.price,this.name,this.oncall,this.imageurl,this.productid,this.productunit});

  @override
  State<SingleProduct> createState() => _SingleProductState();
}

class _SingleProductState extends State<SingleProduct> {
  ProductProvider? productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider=Provider.of(context);
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GestureDetector(
          onTap:widget.oncall!,
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.green[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                height: 250,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),

                            child: Center(
                              child: Image(

                                image: NetworkImage(widget.imageurl!,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(widget.name!),
                      Text(
                        "${widget.price!}\$/50 Gram",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                               child:   Unitdata(
                                 title: "50 gram",
                                 onTap: (){
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
                                             Divider(height: 1,),
                                             ListTile(
                                               title: new Text('500 gram'),
                                               onTap: () {
                                                 Navigator.pop(context);
                                               },
                                             ),
                                             Divider(height: 1,),
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
                                 //     (){
                                 //   showModalBottomSheet(
                                 //       backgroundColor: Colors.green[100],
                                 //       context: context,
                                 //       builder: (context) {
                                 //         return Column(
                                 //           mainAxisSize: MainAxisSize.min,
                                 //           children:widget.productunit!.map<Widget>((data){
                                 //             return Column(
                                 //               children: [
                                 //                 InkWell(
                                 //                   onTap: ()async{
                                 //                     Navigator.of(context).pop();
                                 //                   },
                                 //                   child: Text(data),
                                 //                 )
                                 //               ],
                                 //             );
                                 //           }).toList() ,
                                 //         );
                                 //       });
                                 // },
                               ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Count(
                                productid:widget.productid ,
                                productimage: widget.imageurl,
                                productname: widget.name,
                                productprice:int.parse(widget.price!),
                                // productquantity:qunatity==null?1:qunatity ,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
