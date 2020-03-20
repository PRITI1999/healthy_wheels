import 'package:flutter/material.dart';
import 'package:healthywheels/screens/basic_skeleton.dart';
import 'package:healthywheels/ui_modules/custom_clippers.dart';
import 'package:healthywheels/util/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

var authHandler = new Auth();
final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginPage extends StatefulWidget{
  LoginPage({Key key}) : super(key: key);
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

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
    } else {
      return null;
    }
  }

  Widget _buildPageContent(BuildContext context) {
    return Container(
      color: Colors.orange.shade100,
      child: ListView(
        children: <Widget>[
          SizedBox(height: 30.0,),
          CircleAvatar(child: Image.asset("assets/images/logo.png"), maxRadius: 100, backgroundColor: Colors.transparent,),
          SizedBox(height: 20.0,),
          _buildLoginForm(context),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.pushNamed(context, 'signup');
                  //builder: (BuildContext context) => SignupOnePage()
                  // ));
                },
                child: Text("Sign Up", style: TextStyle(color: Colors.orange, fontSize: 18.0)),
              )
            ],
          )
        ],
      ),
    );
  }

  Container _buildLoginForm(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Stack(
        children: <Widget>[
          ClipPath(
            clipper: OvalTopBorderClipper(),
            child: Container(
              height: 400,
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40.0)),
                color: Colors.white,
              ),
              child: Form(
                key: _loginFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 90.0,),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: emailTextController,
                          validator: emailValidator,
                          style: TextStyle(color: Colors.black),
                          decoration: InputDecoration(
                              hintText: "Email address",
                              hintStyle: TextStyle(color: Colors.orange.shade200),
                              border: InputBorder.none,
                              icon: Icon(Icons.email, color: Colors.orange,)
                          ),
                        )
                    ),
                    Container(child: Divider(color: Colors.orange.shade400,), padding: EdgeInsets.only(left: 20.0,right: 20.0, bottom: 10.0),),
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextFormField(
                          controller: passwordTextController,
                          validator: passwordValidator,
                          style: TextStyle(color: Colors.black),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(padding: EdgeInsets.only(right: 20.0),
                            child: Text("Forgot Password",
                              style: TextStyle(color: Colors.black45),
                            )
                        )
                      ],
                    ),
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
            height: 420,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: (){
                  //print({emailTextController.text, passwordTextController.text});
                  if(_loginFormKey.currentState.validate()){
                    _auth.signInWithEmailAndPassword(
                        email: emailTextController.text,
                        password: passwordTextController.text)
                        .then((currentUser) => Firestore.instance
                          .collection("users")
                          .document(currentUser.user.uid)
                          .get()
                          .then((DocumentSnapshot result) => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BasicPage(0),
                            ),
                            ))
                          .catchError((err) => print(err))
                        .catchError((err) => print(err)));
                  }
                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                child: Text("Login", style: TextStyle(color: Colors.white70),textScaleFactor: 1.5,),
                color: Colors.orange,
              ),
            ),
          ),
          /*Container(
            height: 500,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: (){

                },
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.0)),
                child: Text("Sign up with Google", style: TextStyle(color: Colors.white70),textScaleFactor: 1.5,),
                color: Colors.orange,
              ),
            ),
          )*/
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