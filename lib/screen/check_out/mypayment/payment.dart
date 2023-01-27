import 'package:flutter/material.dart';
import 'package:pay/pay.dart';
class Payment extends StatefulWidget {
  double?total;
  Payment({this.total});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {


  void onGooglePayResult(paymentResult) {
    print(paymentResult);
  }
  @override
  Widget build(BuildContext context) {

    // onGooglePayResult();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text("Online Payment"),),
        body: Center(
          child: GooglePayButton(
            paymentConfigurationAsset: 'sample_payment_configuration.json',
            paymentItems:[
              PaymentItem(
                label: 'Total',
                amount: '${widget.total}',
                status: PaymentItemStatus.final_price,
              )
            ],
            // style: GooglePayButtonStyle.black,
            type: GooglePayButtonType.pay,
            onPaymentResult: onGooglePayResult,
             // width = RawGooglePayButton.minimumButtonWidt,
             // height = RawGooglePayButton.defaultButtonHeight,
            // height: 30,
            // width: 160,

          ),
        ),
      ),
    );
  }
}
