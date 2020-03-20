import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthywheels/ui_modules/src/oval_top_border_clipper.dart';

class CategoryCard extends StatelessWidget {
  String categoryTitle;
  CategoryCard(String categoryTitle) {
    this.categoryTitle = categoryTitle;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: 200,
            padding: EdgeInsets.all(10.0),
            child: ClipPath(
                clipper: OvalTopBorderClipper(),
                child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      color: Colors.orange.shade300,
                    ),
                    child: Container(
                        height: 50,
                        width: 300,
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: Center(
                            child:
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                                  colors: [Colors.orange.shade50, Colors.orange.shade300], // whitish to gray
                                  tileMode: TileMode.mirror, // repeats the gradient over the canvas
                                ),
                              ),
                              alignment: Alignment(-1, 0.2),
                              child:Container(
                                height: 50,
                                width: 200,
                                decoration: BoxDecoration(color: Colors.white70,
                                    borderRadius: BorderRadius.circular(10.0), border: Border.all(
                                      width: 1,
                                      color: Colors.orange.shade200,
                                    )),
                                alignment: Alignment(0,-0.1),
                                child: Text(
                                      categoryTitle,
                                      textAlign: TextAlign.center,
                                      textScaleFactor: 2.5,
                                      style: TextStyle(
                                        color: Colors.orange.shade600,
                                        fontWeight: FontWeight.w900,
                                      )
                                  ),
                                )
                              ),
                            )
                        )
                    )
                )
            )
    );
  }
}