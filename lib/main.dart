import 'package:car_ui/bloc/state_bloc.dart';
import 'package:car_ui/bloc/state_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
//import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'model/car.dart';

void main() => runApp(MyApp());

var currentCar = carlist.cars[0];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: Container(
          margin: EdgeInsets.only(left: 25.0),
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {}
          ),
        ),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 25.0),
            child: IconButton(
              icon: Icon(Icons.favorite_border),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: LayoutStarts(),
    );
  }
}

class LayoutStarts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        CarDetailsAniamtion(),
        CustomBottomSheet(),
      ],
    );
  }
}

class CarDetailsAniamtion extends StatefulWidget {
  @override
  _CarDetailsAniamtionState createState() => _CarDetailsAniamtionState();
}

class _CarDetailsAniamtionState extends State<CarDetailsAniamtion>
    with TickerProviderStateMixin {
  AnimationController fadeController;
  AnimationController scaleController;

  Animation fadeAnimation;
  Animation scaleAnimation;

  @override
  void initState() {
    super.initState();
    fadeController =
        AnimationController(duration: Duration(milliseconds: 180), vsync: this);
    scaleController =
        AnimationController(duration: Duration(milliseconds: 350), vsync: this);

    fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(fadeController);
    scaleAnimation = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: scaleController,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ));
  }

  forward() {
    scaleController.forward();
    fadeController.forward();
  }

  reverse() {
    scaleController.reverse();
    fadeController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        initialData: StateProvider().isAnimating,
        stream: stateBloc.animationSatus,
        builder: (context, snapshot) {
          snapshot.data ? forward() : reverse();
          return ScaleTransition(
            scale: scaleAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Cardetails(),
            ),
          );
        });
  }
}

class Cardetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 30.0),
            child: _carTitle(),
          ),
          Container(
            width: double.infinity,
            child: CarCarousel(),
          )
        ],
      ),
    );
  }
}

class CarCarousel extends StatefulWidget {
  @override
  _CarCarouselState createState() => _CarCarouselState();
}

class _CarCarouselState extends State<CarCarousel> {
  static final List<String> imageList = currentCar.imgList;
  final List<Widget> child = _map<Widget>(imageList, (index, String assetName) {
    return Container(child: Image.asset(assetName, fit: BoxFit.fitWidth));
  }).toList();

  static List<T> _map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CarouselSlider(
            autoPlay: true,
            height: 250,
            viewportFraction: 1.0,
            items: child,
            onPageChanged: (index) {
              setState(() {
                _current = index;
              });
            },
          ),
          Container(
            margin: EdgeInsets.only(
              left: 25.0,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: _map(imageList, (index, assetName) {
                  return Container(
                    width: 50.0,
                    height: 2.0,
                    decoration: BoxDecoration(
                      color: _current == index
                          ? Colors.grey[100]
                          : Colors.grey[600],
                    ),
                  );
                })),
          )
        ],
      ),
    );
  }
}

_carTitle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      RichText(
        text: TextSpan(
            style: TextStyle(
              color: Colors.white,
              fontSize: 38,
            ),
            children: [
              TextSpan(text: currentCar.companyName),
              TextSpan(text: "\n"),
              TextSpan(
                text: currentCar.carName,
                style: TextStyle(fontWeight: FontWeight.w700),
              )
            ]),
      ),
      SizedBox(
        height: 10.0,
      ),
      RichText(
        text: TextSpan(
            style: TextStyle(
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: currentCar.price.toString(),
                style: TextStyle(color: Colors.grey[20]),
              ),
              TextSpan(
                text: "/day",
                style: TextStyle(color: Colors.grey),
              )
            ]),
      )
    ],
  );
}

class CustomBottomSheet extends StatefulWidget {
  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet>
    with SingleTickerProviderStateMixin {
  double sheetTop = 400;
  double minSheetTop = 0;
  Animation<double> animation;
  AnimationController controller;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation = Tween<double>(begin: sheetTop, end: minSheetTop)
        .animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
      reverseCurve: Curves.easeInOut,
    ))
          ..addListener(() {
            setState(() {});
          });
  }

  forwordAnimation() {
    controller.forward();
    stateBloc.toggleAnimation(false);
  }

  reverseAnimation() {
    controller.reverse();
    stateBloc.toggleAnimation(true);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      top: animation.value,
      child: GestureDetector(
        onTap: () {
          setState(() {
            // controller.isCompleted ? reverseAnimation() : forwordAnimation();
          });
        },
        onVerticalDragEnd: (DragEndDetails dragEndDetails) {
          if (dragEndDetails.primaryVelocity < 0.0) {
            forwordAnimation();
          } else if (dragEndDetails.primaryVelocity > 0.0) {
            reverseAnimation();
          } else {
            return;
          }
        },
        child: SheetContainer(),
      ),
    );
  }
}

class SheetContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double sheetItemHight = 110;

    return Container(
      // padding: EdgeInsets.only(left: 25.0),
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
          color: Color(0xfff1f1f1)),
      child: Column(
        children: <Widget>[
          _drawerHandle(),
          Expanded(
              flex: 1,
              child: ListView(
                children: <Widget>[
                  _offerDetails(sheetItemHight),
                  _specification(sheetItemHight),
                  _features(sheetItemHight),
                  SizedBox(
                    height: 220,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

_drawerHandle() {
  return Container(
    margin: EdgeInsets.only(top: 25, bottom: 25),
    height: 3,
    width: 65,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      color: Color(0xffd9dbdb),
    ),
  );
}

_specification(double sheetItemHight) {
  return Container(
    padding: EdgeInsets.only(
      top: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Specification',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: sheetItemHight + 20,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 20.0),
            scrollDirection: Axis.horizontal,
            itemCount: currentCar.specifications.length,
            itemBuilder: (context, index) {
              return ListItme(
                sheetItemHeight: sheetItemHight,
                mapVal: currentCar.specifications[index],
              );
            },
          ),
        )
      ],
    ),
  );
}

_features(double sheetItemHight) {
  return Container(
    padding: EdgeInsets.only(
      top: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Features',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: sheetItemHight + 20,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 20.0),
            scrollDirection: Axis.horizontal,
            itemCount: currentCar.fetures.length,
            itemBuilder: (context, index) {
              return ListItme(
                sheetItemHeight: sheetItemHight,
                mapVal: currentCar.fetures[index],
              );
            },
          ),
        )
      ],
    ),
  );
}

_offerDetails(double sheetItemHight) {
  return Container(
    padding: EdgeInsets.only(
      top: 10,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            'Offer Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontSize: 15,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: sheetItemHight + 20,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 20.0),
            scrollDirection: Axis.horizontal,
            itemCount: currentCar.offerDetails.length,
            itemBuilder: (context, index) {
              return ListItme(
                sheetItemHeight: sheetItemHight,
                mapVal: currentCar.offerDetails[index],
              );
            },
          ),
        )
      ],
    ),
  );
}

class ListItme extends StatelessWidget {
  final double sheetItemHeight;
  final Map mapVal;
  ListItme({
    this.sheetItemHeight,
    this.mapVal,
  });

  @override
  Widget build(BuildContext context) {
    var innerMap;
    bool isMap;

    if (mapVal.values.elementAt(0) is Map) {
      innerMap = mapVal.values.elementAt(0);
      isMap = true;
    } else {
      innerMap = mapVal;
      isMap = false;
    }

    return Container(
      margin: EdgeInsets.only(right: 20, bottom: 20),
      width: sheetItemHeight,
      height: sheetItemHeight,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          mapVal.keys.elementAt(0),
          isMap
              ? Text(
                  innerMap.keys.elementAt(0),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black, letterSpacing: 1.2, fontSize: 11),
                )
              : Container(),
          Text(
            innerMap.values.elementAt(0),
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
