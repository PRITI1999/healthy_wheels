import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthywheels/screens/cart_screen.dart';
import 'package:healthywheels/screens/home_screen.dart';
import 'package:healthywheels/screens/product_screen.dart';
import 'package:healthywheels/ui_modules/bottom_navigation.dart';

class BasicPage extends StatefulWidget {
  int page;
  String categoryName;
  BasicPage(page, {name: ""}){
    this.page = page;
    this.categoryName = name;
  }
  @override
  _BasicPageState createState() => _BasicPageState(page, categoryName);
}
class _BasicPageState extends State<BasicPage> {
  int _currentPage;
  String categoryName;
  String uid;
  _BasicPageState(this._currentPage, this.categoryName);

  @override
  void initState() {
    this.getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    uid = user.uid.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.orange.shade50,
      body: getPage(_currentPage),
      bottomNavigationBar: AnimatedBottomNav(
          currentIndex: _currentPage,
          onChange: (index) {
            setState(() {
              _currentPage = index;
              getPage(_currentPage);
            });
          }),
    );
  }

  getPage(int page) {
    switch(page) {
      case 0:
        return HomePage();
      case 1:
        return Center(child: Container(child: Text("Profile Page"),));
      case 2:
        return CartScreen(uid);
      case 3:
        return ProductScreen(categoryName, uid);
    }
  }

  AppBar appBar() {
    return AppBar(
      title: Text('Healthy Wheels'),
      backgroundColor: Colors.orange.shade300,
      toolbarOpacity: 0.6,
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.shopping_cart,
            semanticLabel: 'cart',
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'cart');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.person,
            semanticLabel: 'profile',
          ),
          onPressed: () {
            Navigator.pushNamed(context, 'profile');
          },
        ),
      ],
    );
  }
}
