import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:vegi/models/userModel.dart';
import 'package:vegi/providers/user_provider.dart';
import 'package:vegi/screen/My_profile/myprofile.dart';
import 'package:vegi/screen/home/homeScreen.dart';
import 'package:vegi/screen/reviewCart/review_chart.dart';
import 'package:vegi/screen/whishlist/whishlist.dart';

class Drawerside extends StatefulWidget {

  UserProvider? userprovider;
  Drawerside({this.userprovider});
  @override
  State<Drawerside> createState() => _DrawersideState();
}

class _DrawersideState extends State<Drawerside> {

  @override
  Widget build(BuildContext context) {
    var userData=widget.userprovider!.userlistdata;
    // print(userData);
    // print(FirebaseAuth.instance.currentUser!.uid);
    // print(userData!.useruid);
    return Drawer(
      child: Container(
        color: Colors.lightGreen,
        child: ListView(
          padding: EdgeInsets.all(2),
          children: [
            Container(
              child: DrawerHeader(

                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 43,
                        backgroundColor: Colors.white54,
                        child: CircleAvatar(
                          backgroundColor: Colors.yellow,
                          backgroundImage: NetworkImage(
                            userData!.userimage ??
                                "https://s3.envato.com/files/328957910/vegi_thumb.png",
                          ),
                          radius: 40,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 8,),
                          Text("${userData.username}",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Brand-Bold',
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            // BrandDivier(),
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: Icon(Icons.home_outlined, color: Colors.white),
              title: Text(
                'Home',
                style: TextStyle(color: Colors.white),
              ),
              onTap: (){
                Navigator.pushNamed(context,HomeScreen.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.shop_outlined, color: Colors.white),
              title: Text('Review cart', style: TextStyle(color: Colors.white)),
              onTap: (){
                Navigator.pushNamed(context, ReviewScreen.id);
              },
            ),
            ListTile(
              leading: Icon(Icons.person_outline, color: Colors.white),
              title: Text('My Profile', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Myprofile(
                  useremail: userData.useremail,
                  userimage: userData.userimage,
                  username: userData.username,
                )));
              },
            ),

            ListTile(
              leading: Icon(Icons.notifications_outlined, color: Colors.white),
              title:
                  Text('Notification', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.star_outline, color: Colors.white),
              title: Text('Rating & Review',
                  style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.favorite_outline, color: Colors.white),
              title: Text('Whistlist', style: TextStyle(color: Colors.white)),
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> WhishlistScreen()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.copy_outlined,
                color: Colors.white,
              ),
              title: Text('Raise a complaint',
                  style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Icon(Icons.question_mark_rounded, color: Colors.white),
              title: Text('FAQs', style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              title: Text(
                "Contect support",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            ListTile(
              leading: Text("Call us", style: TextStyle(color: Colors.white)),
              title: Text("9876543211", style: TextStyle(color: Colors.white)),
            ),
            ListTile(
              leading: Text("Mail us", style: TextStyle(color: Colors.white)),
              title:
                  Text("absd@gmail.com", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}
