import 'package:flutter/material.dart';

class Drink {
  final String name;
  final String imageURL;
  final String drinkID;

  Drink({@required this.name, @required this.imageURL, @required this.drinkID});

  factory Drink.fromJson(Map<String, dynamic> json) {
    return Drink(
      name: json['strDrink'],
      imageURL: json['strDrinkThumb'],
      drinkID: json['idDrink'],
    );
  }
}
