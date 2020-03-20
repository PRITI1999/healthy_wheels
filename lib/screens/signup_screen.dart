import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:healthywheels/ui_modules/custom_clippers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthywheels/screens/basic_skeleton.dart';

//var authHandler = new Auth();
final FirebaseAuth _auth = FirebaseAuth.instance;

class NewUser{
  String name;
  String emailAddress;
  String phoneNumber;
}

class SignupPage extends StatefulWidget{
  SignupPage({Key key}) : super(key: key);
  @override
  SignupPageState createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
  static final String path = "lib/src/pages/login/signup1.dart";
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController confirmPasswordTextController = TextEditingController();
  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.orange.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 30.0,),
          CircleAvatar(child: Image.asset("assets/images/logo.png"), maxRadius: 100, backgroundColor: Colors.transparent,),
          SizedBox(height: 20.0,),
          _buildLoginForm(),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FloatingActionButton(
                mini: true,
                onPressed: (){
                  Navigator.pop(context);
                },
                backgroundColor: Colors.orange,
                child: Icon(Icons.arrow_back),
              )
            ],
          )*/
        ],
      ),
    );
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Email format is invalid';
    } else {
      return null;
    }
  }

  String passwordValidator(String value) {
    if (value.length < 8) {
      return 'Password must be longer than 8 characters';
    } else if(passwordTextController.text != confirmPasswordTextController.text){
      return "Passwords don't match";
    } else {
      return null;
    }
  }

  Container _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalTopBorderClipper(),
            child: Container(
              height: 600,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Form(
                key: _registerFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 90.0,),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: (value) {
                            if(value.length > 3){
                              return null;
                            }
                            return "Enter a valid name";
                          },
                          controller: nameTextController,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              hintText: "Name",
                              hintStyle: TextStyle(color: Colors.orange.shade200),
                              border: InputBorder.none,
                              icon: Icon(Icons.perm_identity, color: Colors.orange,)
                          ),
                        )
                    ),
                    Container(child: Divider(color: Colors.orange.shade400,),
                      padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: emailValidator,
                          controller: emailTextController,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(
                              hintText: "Email address",
                              hintStyle: TextStyle(color: Colors.orange.shade200),
                              border: InputBorder.none,
                              icon: Icon(Icons.email, color: Colors.orange,)
                          ),
                        )
                    ),
                    Container(child: Divider(color: Colors.orange.shade400,),
                      padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: (value){
                            if(value != null){
                              return null;
                            }
                            return "Enter a number";
                          },
                          controller: phoneTextController,
                          style: TextStyle(color: Colors.black87), keyboardType: TextInputType.numberWithOptions(),
                          decoration: InputDecoration(
                              hintText: "Phone number",
                              hintStyle: TextStyle(color: Colors.orange.shade200),
                              border: InputBorder.none,
                              icon: Icon(Icons.phone, color: Colors.orange,)
                          ),
                        )
                    ),
                    Container(child: Divider(color: Colors.orange.shade400,),
                      padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: passwordValidator,
                          controller: passwordTextController,
                          style: TextStyle(color: Colors.black87),
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: TextStyle(color: Colors.orange.shade200),
                              border: InputBorder.none,
                              icon: Icon(Icons.lock, color: Colors.orange,)
                          ),
                        )
                    ),
                    Container(child: Divider(color: Colors.orange.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          validator: passwordValidator,
                          controller: confirmPasswordTextController,
                          style: TextStyle(color: Colors.black87),
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "Confirm password",
                              hintStyle: TextStyle(color: Colors.orange.shade200),
                              border: InputBorder.none,
                              icon: Icon(Icons.lock, color: Colors.orange,)
                          ),
                        )
                    ),
                    Container(child: Divider(color: Colors.orange.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                    SizedBox(height: 10.0,),

                  ],
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 40.0,
                backgroundColor: Colors.orange.shade600,
                foregroundColor: Colors.white70,
                child: Icon(Icons.person),

              ),
            ],
          ),
          Container(
            height: 620,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: (){
                  NewUser user = new NewUser();
                  user.name = nameTextController.text;
                  user.emailAddress = emailTextController.text;
                  user.phoneNumber = phoneTextController.text;
                  print(passwordTextController.text);
                  print(confirmPasswordTextController.text);
                  if(_registerFormKey.currentState.validate()) {
                    if (passwordTextController.text ==
                        confirmPasswordTextController.text) {
                      _auth.createUserWithEmailAndPassword(
                          email: user.emailAddress,
                          password: passwordTextController.text)
                          .then((currentUser) =>
                          Firestore.instance.collection("users")
                              .document(currentUser.user.uid)
                              .setData({
                            "uid": currentUser.user.uid,
                            "name": user.name,
                            "email": user.emailAddress,
                            "phone": user.phoneNumber})
                              .then((result) => {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => BasicPage(0, currentUser.user.uid)
                                  )
                                )
                          })
                              .catchError((err) => print(err))
                      ).catchError((err) => print(err));
                    }
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                child: Text("Sign Up", style: TextStyle(color: Colors.white70), textScaleFactor: 1.5,),
                color: Colors.orange,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPageContent(context),
    );
  }
}