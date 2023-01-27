import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/product_provider.dart';
import 'package:vegi/providers/user_provider.dart';
import 'package:vegi/screen/Search/search_screen.dart';
import 'package:vegi/screen/home/drawer_side.dart';
import 'package:vegi/screen/home/singe_product.dart';
import 'package:vegi/screen/product_overview/productOverview.dart';
import 'package:vegi/screen/reviewCart/review_chart.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    ProductProvider productProvider = Provider.of(context, listen: false);
    productProvider.vegproductData();
    productProvider.fruitProductData();
    super.initState();
  }

  ProductProvider? productProvider;

  Widget _builtveg(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Vegetable"),
              GestureDetector(
                onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen(search: productProvider!.getvegproductData,)));
                },
                child: Center(
                  child: Text("View all",
                  style: TextStyle(color: Colors.grey),),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              children: productProvider!.getvegproductData.map((vegData) {
                return SingleProduct(
                  imageurl: vegData.productImage,
                  name: vegData.productName,
                  price: vegData.productPrice.toString(),
                  productid: vegData.productid,
                  productunit: vegData.productunit,
                  oncall: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductOverview(
                              name: vegData.productName,
                              price: vegData.productPrice.toString(),
                              imageurl: vegData.productImage,
                              productid: vegData.productid,
                             isAdd: true,
                             quantity:2,
                            )));
                  },
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }
  Widget _builtfruit(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Fruit"),
              GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen(search: productProvider!.getfruitproductData,)));
                },
                child: Center(
                  child: Text("View all",
                    style: TextStyle(color: Colors.grey),),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 3,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            child: Row(
              children: productProvider!.getfruitproductData.map((fruitData) {
                return SingleProduct(
                  imageurl: fruitData.productImage,
                  name: fruitData.productName,
                  price: fruitData.productPrice.toString(),
                  productid: fruitData.productid,
                  productunit: fruitData.productunit,
                  oncall: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ProductOverview(
                          name: fruitData.productName,
                          price: fruitData.productPrice.toString(),
                          imageurl: fruitData.productImage,
                          productid: fruitData.productid,
                          isAdd: true,
                          quantity:2,

                        )));
                  },
                );
              }).toList(),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of(context);
    UserProvider userProvider=Provider.of(context,listen: false);
    userProvider.userData();
    // print(userProvider!.userlistdata!.username);
    return Scaffold(
      drawer: Drawerside(userprovider: userProvider,),
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Home",
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundColor: Colors.lightGreen,
              radius: 18,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SearchScreen(
                    search: productProvider!.getsearchListData,
                  )));
                },
                icon: Icon(
                  Icons.search,
                  size: 21,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.lightGreen,
              radius: 18,
              child:Center(
                child: IconButton(
                  onPressed: (){
                    Navigator.pushNamed(context, ReviewScreen.id);
                  },
                  icon: Icon(Icons.shop),
                  color: Colors.white,
                  iconSize: 21,

                ),
              )
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      "https://cdn.shopify.com/s/files/1/0252/0904/5067/articles/image4_abe64529-18c4-4455-add4-81808cdcb7c5_600x.png?v=1669203484"),
                ),
                color: Colors.blue,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "30%  Off",
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          BoxShadow(
                            color: Colors.red,
                            spreadRadius: 5,
                            offset: Offset(3, 3),
                          )
                        ]),
                  )
                ],
              ),
            ),
          ),

          _builtveg(context),
          _builtfruit(context),
        ],
      ),
    );
  }
}
