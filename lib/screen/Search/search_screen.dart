import 'package:flutter/material.dart';

import 'package:vegi/screen/widgets/singleitem.dart';

import '../../models/productModel.dart';

class SearchScreen extends StatefulWidget {
  static const String id = 'Serchscreen';
  List <ProductModel>? search=[];
  SearchScreen({this.search});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String Query="";
   searchItem(String? query)
  {
    List<ProductModel>? searchfood=widget.search!.where((element){
      return element.productName!.toLowerCase().contains(query!);
    }).toList();
    return searchfood;
  }
  
  @override
  Widget build(BuildContext context) {
     List<ProductModel> _searchitem=searchItem(Query);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                ListTile(
                  title: Text("Item"),
                ),
                Container(
                  height: 52,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                     onChanged: (value){
                       setState(() {
                         Query=value;
                       });
                     },
                    decoration: InputDecoration(
                      fillColor: Colors.green,
                      filled: true,
                      hintText: "Search for item in the store",
                      hintStyle: TextStyle(color: Colors.white),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),

                    ),

                  ),
                ),
                SizedBox(height: 10,),


              ],
            ),
            SizedBox(height: 20,),

            Column(
              children:_searchitem.map((data) {
            return SingleItem(
              name: data.productName,
              image: data.productImage,
              price: data.productPrice.toString(),
              productid: data.productid,
            );
              } ).toList() ,
            )
          ],
        ),
      ),
    );
  }
}
