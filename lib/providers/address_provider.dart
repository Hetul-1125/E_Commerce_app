import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:location/location.dart';
import 'package:vegi/models/addressModel.dart';

class AddressProvider extends ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController alternateMobileNo = TextEditingController();
  TextEditingController scoiety = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController landmark = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController aera = TextEditingController();
  TextEditingController pincode = TextEditingController();
  LocationData? setLoaction;

  void validator(context, myType) async {
    if (firstName.text.isEmpty) {
      Fluttertoast.showToast(msg: "firstname is empty");
    } else if (lastName.text.isEmpty) {
      Fluttertoast.showToast(msg: "lastname is empty");
    } else if (mobileNo.text.isEmpty&&mobileNo.text.length==10) {
      Fluttertoast.showToast(msg: "Enter a vallid mobile number");
    } else if (alternateMobileNo.text.isEmpty&&alternateMobileNo.text.length==10) {
      Fluttertoast.showToast(msg: "Enter a vallid alternative mobile number");
    } else if (scoiety.text.isEmpty) {
      Fluttertoast.showToast(msg: "scoiety is empty");
    } else if (street.text.isEmpty) {
      Fluttertoast.showToast(msg: "street is empty");
    } else if (landmark.text.isEmpty) {
      Fluttertoast.showToast(msg: "landmark is empty");
    } else if (city.text.isEmpty) {
      Fluttertoast.showToast(msg: "city is empty");
    } else if (aera.text.isEmpty) {
      Fluttertoast.showToast(msg: "aera is empty");
    } else if (pincode.text.isEmpty&&pincode.text.length==6) {
      Fluttertoast.showToast(msg: "Enter a valid pincode with 6 character");
    } else if (setLoaction == null) {
      Fluttertoast.showToast(msg: "setLoaction is empty");
    } else {
      notifyListeners();
      await FirebaseFirestore.instance
          .collection("deliveryaddress")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
        "firstname": firstName.text,
        "lastname": lastName.text,
        "mobileNo": mobileNo.text,
        "alternateMobileNo": alternateMobileNo.text,
        "scoiety": scoiety.text,
        "street": street.text,
        "landmark": landmark.text,
        "city": city.text,
        "aera": aera.text,
        "pincode": pincode.text,
        "addressType": myType.toString(),
        "longitude": setLoaction!.longitude,
        "latitude": setLoaction!.latitude,
      }).then((value) async {
        notifyListeners();
        await Fluttertoast.showToast(msg: "Add your deliver address");
        Navigator.of(context).pop();
        notifyListeners();
      });
      notifyListeners();
    }
  }
  AddressModel? addressModel;
List<AddressModel> addressDatalist=[];
  getdeliveryaddress() async {
    List<AddressModel> newList=[];
    DocumentSnapshot vlaue = await FirebaseFirestore.instance
        .collection("deliveryaddress")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if(vlaue.exists)
      {
       addressModel=AddressModel(
            firstname:vlaue.get("firstname"),
           lastname:vlaue.get("lastname"),
             mobilenumber:vlaue.get("mobileNo"),
         secondmobilenumber:vlaue.get("alternateMobileNo"),
         society:vlaue.get("scoiety"),
             streat:vlaue.get("street"),
             landmark:vlaue.get("landmark"),
             city:vlaue.get("city"),
        area:vlaue.get("aera"),
         pincode:vlaue.get("pincode"),
             addresstype:vlaue.get("addressType"),
          
        );
            newList.add(addressModel!);
      }
    addressDatalist=newList;
    notifyListeners();

  }
  List<AddressModel> get getaddressData{
    return addressDatalist;
  }


  // setAddress({
  //     BuildContext? context,
  //     String? firstname,
  //     String? middlename,
  //     String? lastname,
  //     String? mobilenumber,
  //     String? secondmobilenumber,
  //     String? society,
  //     String? streat,
  //     String? landmark,
  //     String? city,
  //     String? area,
  //     String? pincode,
  //     String? addresstype,
  //   LocationData? locationData,
  // }) async {
  //   await FirebaseFirestore.instance
  //       .collection("deliveraddress")
  //       .doc(FirebaseAuth.instance.currentUser!.uid)
  //       .set({
  //     "firstname":firstname,
  //      "middlename":middlename,
  //      "lastname":lastname,
  //      "mobilenumber":mobilenumber,
  //      "secondmobilenumber":secondmobilenumber,
  //     "society":society,
  //      "streat":streat,
  //      "landmark":landmark,
  //      "city":city,
  //      "area":area,
  //      "pincode":pincode,
  //      "addresstype":addresstype,
  //       "longitude":locationData!.longitude,
  //      "latitude":locationData.latitude,
  //   }).then((value) async {
  //     await Fluttertoast.showToast(msg: "Your delivery address is added");
  //     Navigator.of(context!).pop();
  //     notifyListeners();
  //   });
  //   notifyListeners();
  // }
}
