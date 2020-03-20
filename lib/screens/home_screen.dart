import 'package:flutter/material.dart';
import 'package:healthywheels/util/show_categories.dart';
import 'package:healthywheels/ui_modules/custom_clippers.dart';

class HomePage extends StatefulWidget {
  String uid;
  HomePage(String uid){
    this.uid = uid;
  }
  @override
  _HomePageState createState() => _HomePageState(uid);
}

class _HomePageState extends State<HomePage> {
  String uid;
  _HomePageState(this.uid);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ClipPath(
            clipper: SideCutClipper(),
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.orange.shade400,
                  /*image: const DecorationImage(
                    image: NetworkImage('https:///flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg'),
                    fit: BoxFit.cover,
                  ),*/
                  border: Border.all(
                    color: Colors.orange.shade50,
                    width: 8,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  gradient: RadialGradient(
                    center: const Alignment(0.1, 0), // near the top right
                    radius: 0.2,
                    colors: [
                      Colors.orange.shade300, // yellow sun
                      Colors.orange.shade400, // blue sky
                    ],
                    tileMode: TileMode.repeated,
                    stops: [0.1, 2.0],
                  ),
                ),
              child: Image.asset('assets/images/logo.png'),
              height: 200,
            ),
          ),
          Container(
            padding: EdgeInsets.all(10.0),
            child: ClipPath(
              clipper: OvalTopBorderClipper(),
              child: Container(
                child: ShowCategories(uid),
                padding: EdgeInsets.all(10.0),
                height: 450,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40.0)),
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
