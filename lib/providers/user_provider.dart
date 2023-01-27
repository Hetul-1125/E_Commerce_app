import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vegi/models/userModel.dart';

class UserProvider extends ChangeNotifier {

  addUserData({User? currentuser,String?username,String?useremail,String?userimage}) async {
    FirebaseFirestore.instance.collection("userData").doc(currentuser!.uid).set({
      "username":username,
      "useremail": useremail,
      "userimage": userimage,
      "useruid": currentuser.uid,
    });
  }
  UserModel? userlistdata;
  userData() async {
    UserModel userModel;
    var value = await FirebaseFirestore.instance
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      userModel = UserModel(
          username: value.get("username"),
          userimage: value.get("userimage"),
          useruid: value.get("useruid"),
          useremail: value.get("useremail"));
      userlistdata = userModel;
      notifyListeners();
    }
  }

  UserModel get getuserdata {
    return userlistdata!;
  }
}
