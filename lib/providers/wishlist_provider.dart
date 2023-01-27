import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/review_chary_model.dart';

class WhishlistProvider extends ChangeNotifier {
  ReviewChartModel? whishlistModel;
  List<ReviewChartModel> whishlistListData = [];
  addwhishlistData(
      {String? whishlistname,
      String? whishlistimage,
      String? whishlistid,
      int? whishlistprice,
      int? quantity,
      bool? isAdd = true}) async {
    await FirebaseFirestore.instance
        .collection("whishlistdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourwhislistdata")
        .doc(whishlistid)
        .set(
      {
        "whishlistname": whishlistname,
        "whishlistimage": whishlistimage,
        "whishlistprice": whishlistprice,
        "whishlistid": whishlistid,
        "whishlistquantity": quantity,
        "isAdd": isAdd,
      },
    );
  }
  ////////////////////////deletwhishlistData//////////////////////////

  whishlistDeletData(String? productid) async {
    await FirebaseFirestore.instance
        .collection("whishlistdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourwhislistdata")
        .doc(productid)
        .delete();
    notifyListeners();
  }
  ///////////////////////////getWhishlistData///////////////////////////////////////

  WhishlistData(
      {String? whishlistname,
      String? whishlistimage,
      String? whishlistid,
      int? whishlistprice,
      int? quantity,
      bool? isAdd}) async {
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("whishlistdata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourwhislistdata")
        .get();
    List<ReviewChartModel> newList=[];
    value.docs.forEach((element) {

     whishlistModel=ReviewChartModel(
       productid: element.get("whishlistid"),
       productimage: element.get("whishlistimage"),
       productname: element.get("whishlistname"),
       productprice: element.get("whishlistprice"),
       quantity: element.get("whishlistquantity"),
       isAdd: element.get("isAdd"),

     );
     newList.add(whishlistModel!);

    });
    whishlistListData=newList;
    notifyListeners();
  }
  List<ReviewChartModel>get getWhishlistData{
    return whishlistListData;
  }

}
