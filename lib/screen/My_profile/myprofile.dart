import 'package:flutter/material.dart';
import 'package:vegi/screen/home/drawer_side.dart';

class Myprofile extends StatefulWidget {
  static const String id = 'Myprofile';
  String?username;
  String?useremail;
  String?userimage;
  Myprofile({this.username,this.userimage,this.useremail});

  @override
  State<Myprofile> createState() => _MyprofileState();
}

class _MyprofileState extends State<Myprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen,
      appBar: AppBar(
        title: Text('My Profile'),
        backgroundColor: Colors.green,
      ),
      // drawer: Drawerside(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.lightGreen,
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: 100,
                            width: double.infinity,
                            // color: Colors.red,
                            child: Row(
                              children: [
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 150, top: 30),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text("${widget.username}"),
                                      Text("${widget.useremail}"),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 25,
                                ),
                                CircleAvatar(
                                  radius: 15,
                                  backgroundColor: Colors.green,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.green,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      Expanded(
                        // height: double.infinity,
                        child: ListView(
                          scrollDirection: Axis.vertical,
                          children: [

                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: Text("My order"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Icon(Icons.shop_outlined),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: Text("Refer a friend"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Icon(Icons.person_outline),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: Text("Term & condition"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Icon(Icons.file_copy_outlined),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: Text("Privacy Policy"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Icon(Icons.policy_outlined),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: Text("About"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Icon(Icons.add_shopping_cart_outlined),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: Text("Log Out"),
                              trailing: Icon(Icons.arrow_forward_ios),
                              leading: Icon(Icons.exit_to_app_outlined),
                            ),
                            Divider(
                              height: 1,
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 45, left: 20),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.lightGreen ,
              child: CircleAvatar(
                backgroundImage: NetworkImage("${widget.userimage}??https://s3.envato.com/files/328957910/vegi_thumb.png"),
                radius: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
