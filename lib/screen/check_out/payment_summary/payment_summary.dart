import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vegi/models/addressModel.dart';
import 'package:vegi/screen/check_out/mypayment/payment.dart';
import 'package:vegi/screen/check_out/payment_summary/order_item.dart';
import 'package:vegi/screen/home/homeScreen.dart';

import '../../../providers/review_chat_provider.dart';
import '../Single_delivery_item.dart';
class PaymentSummary extends StatefulWidget {
  final e;
  PaymentSummary({this.e});

  @override
  State<PaymentSummary> createState() => _PaymentSummaryState();
}
enum PaymentType{
  Cash_On_Delivery,
  Online

}

class _PaymentSummaryState extends State<PaymentSummary> {
  ReviewChartProvider? reviewChartProvider;
  var myType=PaymentType.Online;

  @override
  Widget build(BuildContext context) {
    reviewChartProvider=Provider.of(context);
    reviewChartProvider!.reviewProductData();
    double subtotal=reviewChartProvider!.getTotal();
    double shprice=120;
    double distotal=subtotal*30/100;
    double total=subtotal+shprice;
    if(total>700)
      {
        total=total-distotal;
      }

    return Scaffold(
      appBar: AppBar(title: Text("Payment Summary",),
      backgroundColor: Colors.green,),
      bottomNavigationBar: ListTile(
        title: Text("Total Amount"),
        subtitle: Text("\$ ${total}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 20),),
        trailing: MaterialButton(
          onPressed: ()async{
            if(
            myType==PaymentType.Online){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Payment(total: total,)));}

            else{
              Fluttertoast.showToast(msg: "Your Order is placed");
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomeScreen()));
            }

          },
          height: 47,
            minWidth: 160,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: Colors.green,
          child: Text("Place Order",style: TextStyle(color: Colors.white,fontSize: 16),),
        ),
      ),
      body: ListView.builder(
        itemCount: 1,
          itemBuilder: (context,index){
        return Column(
          children: [
           Container(
             child: SingleDelivery(
               address:
               "${widget.e.area} ${widget.e.streat} ${widget.e.society} ${widget.e.pincode}",
               addressType: widget.e.addresstype=="Addresstype.Work"?"Work":widget.e.addresstype=="Addresstype.Home"?"Home":"other",
               number: widget.e.mobilenumber,
               title: "${widget.e.firstname}  ${widget.e.lastname}",
             ),
           ),
            Divider(height: 3,),
            ExpansionTile(title:Text("Oreder iteam  ${reviewChartProvider!.reviewListData.length}"),
            children:reviewChartProvider!.reviewListData.map((e) {
              return OrderItem(
                    data: e,
              );
            }).toList() ),
            Divider(),
            ListTile(
              trailing: Text("\$ ${subtotal}"),
              title: Text("Sub Total"),

            ),
            Divider(),
            ListTile(
              trailing: Text("\$ ${shprice}"),
              title: Text("Shipping  Charge "),

            ),
              Divider(),
              ListTile(
              trailing:total>700? Text("\$ ${distotal}"):Text("Oreder above 700"),

              title: Text("Code Discount"),

            ),
            Divider(),
            ListTile(
              title:Text("Paymetn Option") ,
            ),

            RadioListTile(
              title: Text("Cash  On Delivery"),
              secondary: Icon(Icons.home),
              value: PaymentType.Cash_On_Delivery, groupValue:myType, onChanged: (PaymentType? value){
              setState(() {
                myType=value!;
              });
            },
            ),
            RadioListTile(
              secondary: Icon(Icons.paypal),
              title: Text("Online Payment"),
                value: PaymentType.Online, groupValue:myType, onChanged: (PaymentType? value){
              setState(() {
                myType=value!;
              });
            }),



          ],
        );
      }),


    );
  }
}
