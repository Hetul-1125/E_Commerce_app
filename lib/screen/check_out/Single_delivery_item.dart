import 'package:flutter/material.dart';

class SingleDelivery extends StatelessWidget {
  String? address;
  String? number;
  String? title;
  String? addressType;
  SingleDelivery({this.title, this.address, this.addressType, this.number});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            Icons.fiber_manual_record_rounded,
            color: Colors.green,
          ),
          title: Text(title!),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(address!),
              SizedBox(height: 3,),
              Text(number!),
            ],
          ),
          trailing: Container(
            height: 33,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
                child: Text(
              addressType!,
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
        Divider(height: 35,)
      ],
    );
  }
}
