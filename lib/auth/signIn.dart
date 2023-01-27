import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:vegi/providers/user_provider.dart';
import 'package:vegi/screen/home//homeScreen.dart';
class signIn extends StatefulWidget {
  static const String id="signIn";

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  UserProvider? userProvider;
  bool spinner=true;
  @override
  Widget build(BuildContext context) {
    Future<UserCredential> signInWithGoogle() async {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      setState(() {
        spinner=true;
      });
      // UserProvider.;
      // Once signed in, return the UserCredential
      userProvider!.addUserData(
        currentuser: FirebaseAuth.instance.currentUser,
        userimage: googleUser!.photoUrl,
        username: googleUser.displayName,
        useremail: googleUser.email

      );
      return await FirebaseAuth.instance.signInWithCredential(credential);

    }
    userProvider=Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          // color: Colors.blue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                // color:Colors.red ,
              height: 400,width: double.infinity,
                child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [


                    Container(child: Text('Sign in to continue'),),

                    Container(child: Center(child: Text("Vegi",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 80,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Brand-Reguler',
                        shadows: [
                          BoxShadow(
                            color: Colors.green,
                            blurRadius: 10,
                            offset: Offset(3,3),),

                        ]
                    ),
                    )),),
                    SignInButton(
                        Buttons.Google,
                        onPressed: (){
                          signInWithGoogle().then((value) => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>HomeScreen())));
                                 // await signInWithGoogle();
                                 setState(() {
                                   spinner=false;
                                 });
                        }

                      ),
                    SignInButton(
                        Buttons.Apple,
                        onPressed: ()async {

                        },
                      ),
                    Text("By signing in you are agrreing our",style: TextStyle(color:Colors.grey),),
                    Text("Terms and Pricacy Policy",style: TextStyle(color:Colors.grey),),


                  ],
                ),
              ),
              Container(
                color: Colors.red,

                child: Image(image:AssetImage('assets/background.png') ,
                fit: BoxFit.fitWidth,),


              ),
            ],
          ),
        ),
      ),
    );
  }
}
