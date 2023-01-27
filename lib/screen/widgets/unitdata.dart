import 'package:flutter/material.dart';
class Unitdata extends StatelessWidget {
  String?title;
  void Function()? onTap;
  Unitdata({this.onTap,this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap!,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(5),
        ),
        height:33 ,
        width: 90,
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '50 gram',
              style: TextStyle(
                  color: Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
