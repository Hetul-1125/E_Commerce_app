import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/models/addressModel.dart';
import 'package:vegi/providers/address_provider.dart';
import 'package:vegi/providers/review_chat_provider.dart';
import 'package:vegi/screen/check_out/Single_delivery_item.dart';
import 'package:vegi/screen/check_out/add_delivery%20_address/add_deliveryaddress.dart';
import 'package:vegi/screen/check_out/payment_summary/payment_summary.dart';

class DeliveryData extends StatefulWidget {
  const DeliveryData({Key? key}) : super(key: key);

  @override
  State<DeliveryData> createState() => _DeliveryDataState();
}

class _DeliveryDataState extends State<DeliveryData> {

  AddressProvider? addressProvider;
   AddressModel? value;
  @override
  Widget build(BuildContext context) {
    addressProvider = Provider.of(context);
    addressProvider!.getdeliveryaddress();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Delivery Details"),
          backgroundColor: Colors.green,
        ),
        bottomNavigationBar: Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, bottom: 15, top: 5),
          child: MaterialButton(
            height: 40,
            onPressed: () {
              addressProvider!.addressDatalist.isEmpty
                  ? Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddDeliveryAddress()))
                  : Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PaymentSummary(e:value ,)));
            },
            color: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: addressProvider!.addressDatalist.isEmpty
                ? Text("Add new Address")
                : Text("Payment Summary"),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddDeliveryAddress()));
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text("Delivery To"),
            ),
            Divider(
              height: 5,
              color: Colors.grey,
            ),
            addressProvider!.addressDatalist.isEmpty
                ? Container(
                    child: Center(
                      child: Text("No Data"),
                    ),
                  )
                : Column(
                    children: addressProvider!.addressDatalist.map((e) {
                      setState(() {
                        value=e;
                      });
                      return SingleDelivery(
                        address:
                            "${e.area} ${e.streat} ${e.society} ${e.pincode}",
                        addressType: e.addresstype=="Addresstype.Work"?"Work":e.addresstype=="Addresstype.Home"?"Home":"other",
                        number: e.mobilenumber,
                        title: "${e.firstname}  ${e.lastname}",
                      );
                    }).toList(),
                  )
          ],
        ),
      ),
    );
  }
}
