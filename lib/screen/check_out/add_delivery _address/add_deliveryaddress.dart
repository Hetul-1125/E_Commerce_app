import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/address_provider.dart';
import 'package:vegi/screen/check_out/setlocation/setlocation.dart';

import 'customTextfield.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

enum Addresstype { Home, Work, Other }

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {

  var myType = Addresstype.Home;
  showsnackbar(String title) {
    final message = SnackBar(content: Text(title));
    ScaffoldMessenger.of(context).showSnackBar(message);
  }

  AddressProvider? addressProvider;
  @override
  Widget build(BuildContext context) {
    addressProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Delivery Address"),
        backgroundColor: Colors.green,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 5),
        child: MaterialButton(
          height: 40,
          onPressed: () {
            addressProvider!.validator(context, myType);

          },
          color: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text("Add Address"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: ListView(
          children: [
            CostomTextField(
              labText: "First name",
              controller: addressProvider!.firstName,
            ),
            CostomTextField(
              labText: "Last name",
              controller: addressProvider!.lastName,
            ),
            CostomTextField(
              labText: "Mobile No",
              controller: addressProvider!.mobileNo,
              keyboardtype: TextInputType.number,
            ),
            CostomTextField(
              labText: "Alternate Mobile No",
              controller: addressProvider!.alternateMobileNo,
              keyboardtype: TextInputType.number,
            ),
            CostomTextField(
              labText: "Scoiety",
              controller: addressProvider!.scoiety,
            ),
            CostomTextField(
              labText: "Street",
              controller: addressProvider!.street,
            ),
            CostomTextField(
              labText: "Landmark",
              controller: addressProvider!.landmark,
              keyboardtype: TextInputType.number,
            ),
            CostomTextField(
              labText: "City",
              controller: addressProvider!.city,
            ),
            CostomTextField(
              labText: "Aera",
              controller: addressProvider!.aera,
            ),
            CostomTextField(
              labText: "Pincode",
              controller: addressProvider!.pincode,
              keyboardtype: TextInputType.number,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => SetLocation(),
                  ),
                );
              },
              child: Container(
                height: 47,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    addressProvider!.setLoaction == null? Text("Set Loaction"):
                    Text("Done!"),
                  ],
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Text("Address Type"),
            RadioListTile(
              value: Addresstype.Home,
              groupValue: myType,
              onChanged: (Addresstype? value) {
                setState(() {
                  myType = value!;
                });
              },
              title: Text("Home"),
              secondary: Icon(Icons.home),
            ),
            RadioListTile(
              value: Addresstype.Work,
              groupValue: myType,
              onChanged: (Addresstype? value) {
                setState(() {
                  myType = value!;
                });
              },
              title: Text("Work"),
              secondary: Icon(Icons.work),
            ),
            RadioListTile(
              value: Addresstype.Other,
              groupValue: myType,
              onChanged: (Addresstype? value) {
                setState(() {
                  myType = value!;
                });
              },
              title: Text("Other"),
              secondary: Icon(Icons.devices_other),
            ),
          ],
        ),
      ),
    );
  }
}
