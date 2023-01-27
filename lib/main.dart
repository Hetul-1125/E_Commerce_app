import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vegi/auth/signIn.dart';
import 'package:vegi/providers/address_provider.dart';
import 'package:vegi/providers/product_provider.dart';
import 'package:vegi/providers/review_chat_provider.dart';
import 'package:vegi/providers/user_provider.dart';
import 'package:vegi/providers/wishlist_provider.dart';
import 'package:vegi/screen/My_profile/myprofile.dart';
import 'package:vegi/screen/Search/search_screen.dart';
import 'package:vegi/screen/check_out/add_delivery%20_address/add_deliveryaddress.dart';
import 'package:vegi/screen/home/homeScreen.dart';
import 'package:vegi/screen/product_overview/productOverview.dart';
import 'package:vegi/screen/reviewCart/review_chart.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:[
    ChangeNotifierProvider<ProductProvider>(
    create: (context)=>ProductProvider(),),
      ChangeNotifierProvider<UserProvider>(
          create: (context)=>UserProvider()),
      ChangeNotifierProvider<ReviewChartProvider>(create: (context)=>ReviewChartProvider()),
      ChangeNotifierProvider<WhishlistProvider>(create: (context)=>WhishlistProvider()),
      ChangeNotifierProvider<AddressProvider>(create: (context)=>AddressProvider()),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
              fontFamily: 'Brand-Bold'
        ),
        // home: HomeScreen(),
        initialRoute: signIn.id,
        routes: {
           HomeScreen.id:(context)=>HomeScreen(),
           signIn.id:(context)=>signIn(),
          Myprofile.id:(context)=>Myprofile(),
          SearchScreen.id:(context)=>SearchScreen(),
          ReviewScreen.id:(context)=>ReviewScreen(),
        },
      ),
    );

  }
}


