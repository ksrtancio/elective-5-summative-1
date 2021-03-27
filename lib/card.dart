import 'package:drinks_app/screens/detailView.dart';
import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({
    Key key,
    @required this.name,
    this.imageURL,
    this.drinkID,
  }) : super(key: key);

  final String name;
  final String imageURL;
  final String drinkID;

  @override
  CardWidgetState createState() => CardWidgetState();
}

class CardWidgetState extends State<CardWidget> {
  void viewDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              DetailsScreen(name: widget.name, drinkID: widget.drinkID)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        viewDetails();
        print("Clicked");
      },
      child: Container(
        width: 170,
        height: 250,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: Image.network(widget.imageURL).image),
              ),
            ),
            Container(
              width: 140,
              height: 45,
              child: Text(
                widget.name,
                overflow: TextOverflow.fade,
                style: new TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(45, 45)),
                  onPressed: () {
                    viewDetails();
                    print(widget.drinkID);
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.preview,
                    size: 30.0,
                  ),
                  padding: EdgeInsets.all(7.0),
                  shape: CircleBorder(),
                ),
                RawMaterialButton(
                  constraints: BoxConstraints.tight(Size(45, 45)),
                  onPressed: () {
                    print("Add to cart");
                  },
                  elevation: 2.0,
                  fillColor: Colors.white,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30.0,
                  ),
                  padding: EdgeInsets.all(7.0),
                  shape: CircleBorder(),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
