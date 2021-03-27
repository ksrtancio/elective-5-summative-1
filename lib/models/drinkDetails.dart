import 'package:flutter/material.dart';

class DrinkDetails {
  final String name;
  final String alternativeName;
  final String imageURL;
  final String category;
  final String alcoholic;
  final String instructions;

  DrinkDetails(
      {@required this.name,
      @required this.alternativeName,
      @required this.imageURL,
      @required this.category,
      @required this.alcoholic,
      @required this.instructions});

  factory DrinkDetails.fromJson(Map<String, dynamic> json) {
    return DrinkDetails(
        name: json['strDrink'],
        alternativeName: json['strDrinkAlternate'] ?? json['strDrink'],
        imageURL: json['strDrinkThumb'],
        category: json['strCategory'],
        alcoholic: json['strAlcoholic'],
        instructions: json['strInstructions']);
  }
}
