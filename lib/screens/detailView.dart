import 'package:drinks_app/models/drinkDetails.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({
    Key key,
    @required this.name,
    @required this.drinkID,
  }) : super(key: key);

  final name;
  final drinkID;

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  Future<DrinkDetails> getResponse() async {
    try {
      final response = await http.get(Uri.parse(
          "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=${widget.drinkID}"));
      if (response.statusCode == 200) {
        DrinkDetails details =
            DrinkDetails.fromJson(jsonDecode(response.body)['drinks'][0]);
        print(details.name);
        return details;
        // Iterable l = jsonDecode(response.body)['drinks'];
        // List<DrinkDetails> drinkDetails =
        //     l.map((model) => DrinkDetails.fromJson(model));
        // return drinkDetails;
      } else {
        throw Exception('Failed to load drink');
      }
    } catch (err) {
      print(err);
      throw Exception('Failed to load drink');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(),
        title: Text(widget.name),
        actions: [],
      ),
      endDrawer: Drawer(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/sse0enkeiwr51.gif'),
              Text(
                'Kyle Stephen Tancio',
                style: TextStyle(fontSize: 25),
              ),
              Text(
                'BS Information Technology: Software Development',
                style: TextStyle(fontSize: 12),
              ),
              Text(
                'Usada Constructions | 宇佐田建設',
                style: TextStyle(fontSize: 12),
              ),
              Divider(
                height: 10,
              ),
              Text("ksrtancio@addu.edu.ph"),
              Text("The fourth of January in the year two thousand"),
              ElevatedButton(
                onPressed: _closeEndDrawer,
                child: const Text('Close Drawer'),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: getResponse(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Wrap(
                      spacing: 20,
                      runSpacing: 20,
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20)),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: Image.network(snapshot.data.imageURL)
                                    .image),
                          ),
                          child: Stack(children: [
                            Center(
                              child: Text(
                                snapshot.data.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: Offset(5.0, 5.0),
                                      blurRadius: 3.0,
                                      color: Colors.black45,
                                    ),
                                  ],
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .95,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white30,
                          ),
                          child: Text(
                            "${snapshot.data.alternativeName}",
                            style: TextStyle(fontSize: 40),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .95,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white30,
                          ),
                          child: Text(
                            "${snapshot.data.category} Category",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .95,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white30,
                          ),
                          child: Text(
                            "${snapshot.data.alcoholic}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .95,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white30,
                          ),
                          child: Text(
                            "${snapshot.data.instructions}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                          child: Image.asset(
                        'assets/images/amelia.gif',
                        width: 220,
                      )),
                      Text(
                        "LOADING...",
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
