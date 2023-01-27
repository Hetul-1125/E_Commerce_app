import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vegi/models/productModel.dart';

class ProductProvider extends ChangeNotifier{
  List<ProductModel> vegProductList=[];
  List<ProductModel>fruitProductList=[];
  List<ProductModel>serchList=[];
  ProductModel? productModel;
  List<ProductModel> search = [];
  productModels(QueryDocumentSnapshot element) {

    productModel = ProductModel(
      productImage: element.get("productimage"),
      productName: element.get("productname"),
      productPrice: element.get("productprice"),
      productid: element.get("productid"),
      // productunit: element.get("productunit") as List<dynamic>,
    );
    // search.add(productModel!);
  }


  vegproductData()async{
    List<ProductModel> newList=[];

     QuerySnapshot value=await FirebaseFirestore.instance.collection("vegProduct").get();
     value.docs.forEach((element) { 
       productModels(element);
       newList.add(productModel!);
       serchList.add(productModel!);
     });
     vegProductList=newList;
  // serchList.add(vegProductList);
     notifyListeners();

  }
   List<ProductModel> get  getvegproductData
  {
    return vegProductList;
  }
  /////////////////////////////////  FruitData///////////////////////////////
  fruitProductData()async{
    List<ProductModel> newList=[];
    QuerySnapshot value=await FirebaseFirestore.instance.collection("fruitProduct").get();
    value.docs.forEach((QueryDocumentSnapshot element) {
      productModels(element);
      newList.add(productModel!);
      serchList.add(productModel!);
    });
    fruitProductList=newList;

    notifyListeners();
  }
  List<ProductModel> get getfruitproductData
  {
    return fruitProductList;
  }
  /////////////////////////////search//////////////////////

   List<ProductModel>get getsearchListData{
    return serchList;

     }
}
