import 'package:flutter/material.dart';

double iconSize = 30;
Carlist carlist = Carlist(cars: [
  Car(
    companyName: 'Lamborgini',
    carName: 'Centenaro Rodesta',
    price: 400000,
    imgList: [
      'images/lamborghini_1.jpg',
      'images/lamborghini_2.jpg',
      'images/lamborghini_3.jpg',
    ],
    offerDetails: [
      {
        Icon(
          Icons.bluetooth,
          size: iconSize,
        ): 'Automatic'
      },
      {
        Icon(
          Icons.airline_seat_individual_suite,
          size: iconSize,
        ): '4 seats'
      },
      {
        Icon(
          Icons.pin_drop,
          size: iconSize,
        ): '6.4L'
      },
      {
        Icon(
          Icons.shutter_speed,
          size: iconSize,
        ): '5HP'
      },
      {
        Icon(
          Icons.invert_colors,
          size: iconSize,
        ): 'Variant Colors'
      },
    ],
    specifications: [
      {
        Icon(
          Icons.av_timer,
          size: iconSize,
        ): {'Milegp(upto)': '14.2 kmpl'}
      },
      {
        Icon(
          Icons.power,
          size: iconSize,
        ): {'Emgine(upto)': '3996 cc'}
      },
      {
        Icon(
          Icons.assignment_late,
          size: iconSize,
        ): {'BHP': '700'}
      },
      {
        Icon(
          Icons.account_balance,
          size: iconSize,
        ): {'More Specs': '14.2 kmpl'}
      },
      {
        Icon(
          Icons.cached,
          size: iconSize,
        ): {'More Specs': '14.2 kmpl'}
      },
    ],
    fetures: [
       {Icon(Icons.bluetooth,size: iconSize,): 'Blooth'},
       {Icon(Icons.usb,size: iconSize,): 'USB Port'},
       {Icon(Icons.power_settings_new,size: iconSize,): 'Keyless'},
       {Icon(Icons.android,size: iconSize,): 'Android Auto'},
       {Icon(Icons.ac_unit,size: iconSize,): 'Ac'},
    ]
  ),
  Car(
    companyName: 'Lamborgini',
    carName: 'Vaneno Rodesta',
    price: 400000,
    imgList: [
      'images/lamborghini_1',
      'images/lamborghini_2',
      'images/lamborghini_3',
    ],
    offerDetails: [
      {
        Icon(
          Icons.bluetooth,
          size: iconSize,
        ): 'Automatic'
      },
      {
        Icon(
          Icons.airline_seat_individual_suite,
          size: iconSize,
        ): '4 seats'
      },
      {
        Icon(
          Icons.pin_drop,
          size: iconSize,
        ): '6.4L'
      },
      {
        Icon(
          Icons.shutter_speed,
          size: iconSize,
        ): '5HP'
      },
      {
        Icon(
          Icons.invert_colors,
          size: iconSize,
        ): 'Variant Colors'
      },
    ],
    specifications: [
      {
        Icon(
          Icons.av_timer,
          size: iconSize,
        ): {'Milegp(upto)': '14.2 kmpl'}
      },
      {
        Icon(
          Icons.power,
          size: iconSize,
        ): {'Emgine(upto)': '3996 cc'}
      },
      {
        Icon(
          Icons.assignment_late,
          size: iconSize,
        ): {'BHP': '700'}
      },
      {
        Icon(
          Icons.account_balance,
          size: iconSize,
        ): {'More Specs': '14.2 kmpl'}
      },
      {
        Icon(
          Icons.cached,
          size: iconSize,
        ): {'More Specs': '14.2 kmpl'}
      },
    ],
    fetures: [
       {Icon(Icons.bluetooth,size: iconSize,): 'Blooth'},
       {Icon(Icons.usb,size: iconSize,): 'USB Port'},
       {Icon(Icons.power_settings_new,size: iconSize,): 'Keyless'},
       {Icon(Icons.android,size: iconSize,): 'Android Auto'},
       {Icon(Icons.ac_unit,size: iconSize,): 'Ac'},
    ]
  ),
]);

class Carlist {
  List<Car> cars;
  Carlist({
    @required this.cars,
  });
}

class Car {
  String companyName;
  String carName;
  int price;
  List<String> imgList;
  List<Map<Icon, String>> offerDetails;
  List<Map<Icon, String>> fetures;
  List<Map<Icon, Map<String, String>>> specifications;
  Car({
    @required this.companyName,
    @required this.carName,
    @required this.price,
    @required this.imgList,
    @required this.offerDetails,
    @required this.fetures,
    @required this.specifications,
  });
}
