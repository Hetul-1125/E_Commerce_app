import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:vegi/models/review_chary_model.dart';

class ReviewChartProvider extends ChangeNotifier {
  List<ReviewChartModel> reviewListData = [];
  addReviewChartData(
      {String? productname,
      String? productimage,
      String? productid,
      int? productprice,
      int? quantity,
      bool?isAdd=true}) async {
    await FirebaseFirestore.instance
        .collection("reviewchardata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourreviewchartdata")
        .doc(productid)
        .set(
      {
        "productname": productname,
        "productimage": productimage,
        "productprice": productprice,
        "productid": productid,
        "productquantity": quantity,
        "isAdd":isAdd,
      },
    );
  }
  ///////////////////////////update/////////////////////////
  updateReviewChartData(
      {String? productname,
        String? productimage,
        String? productid,
        int? productprice,
        int? quantity,
        bool?isAdd=true}) async {
    await FirebaseFirestore.instance
        .collection("reviewchardata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourreviewchartdata")
        .doc(productid)
        .update(
      {
        "productname": productname,
        "productimage": productimage,
        "productprice": productprice,
        "productid": productid,
        "productquantity": quantity,
        "isAdd":isAdd,
      },
    );
  }

  reviewProductData() async {
    List<ReviewChartModel> newList = [];
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection("reviewchardata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourreviewchartdata")
        .get();
    value.docs.forEach((element) {
      ReviewChartModel reviewChartModel = ReviewChartModel(
        productprice: element.get("productprice"),
        productname: element.get("productname"),
        productimage: element.get("productimage"),
        productid: element.get("productid"),
        quantity: element.get("productquantity"),

      );
      newList.add(reviewChartModel);
    });
    reviewListData = newList;
    notifyListeners();
  }

  List<ReviewChartModel> get getreviewListData {
    return reviewListData;
  }


//////////////////////////////////delet /////////////////////////////////
  reviewCartDatadelet(productid) async {
    await FirebaseFirestore.instance
        .collection("reviewchardata")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("yourreviewchartdata")
        .doc(productid)
        .delete();
    notifyListeners();
  }

  ////////////////////////total/////////////////////////

double getTotal(){
    double total=0.0;
    reviewListData.forEach((element) {
      total+=element.productprice!* element.quantity!;
    });

    return total;
}
}
