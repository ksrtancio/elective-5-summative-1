import 'package:drinks_app/card.dart';
import 'package:drinks_app/models/drink.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title = ""}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<Drink>> getResponse() async {
    try {
      final response = await http.get(Uri.parse(
          'https://www.thecocktaildb.com/api/json/v1/1/filter.php?a=Alcoholic'));
      if (response.statusCode == 200) {
        Iterable l = jsonDecode(response.body)['drinks'];
        List<Drink> drinkLists =
            List<Drink>.from(l.map((model) => Drink.fromJson(model)));
        return drinkLists;
      } else {
        throw Exception('Failed to load album');
      }
    } catch (err) {
      print(err);
      throw Exception('Failed to load album');
    }
  }

  void _openEndDrawer() {
    _scaffoldKey.currentState.openEndDrawer();
  }

  void _closeEndDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    // getResponse();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: Image.asset(
            'assets/images/logo.png',
            scale: 7,
          ),
          title: Text('Holo Bar'),
          actions: [
            IconButton(onPressed: _openEndDrawer, icon: Icon(Icons.menu))
          ],
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
        endDrawerEnableOpenDragGesture: true,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 90,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.fitWidth,
                          image: Image.asset('assets/images/holo.gif').image),
                    ),
                  )
                ],
              ),
              Container(height: 20),
              Center(
                child: Text(
                  "Gura's underwater tavern",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(height: 20),
              FutureBuilder(
                future: getResponse(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Center(
                      child: Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          for (var drink in snapshot.data)
                            CardWidget(
                                name: drink.name,
                                imageURL: drink.imageURL,
                                drinkID: drink.drinkID),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/gura.gif',
                          width: 220,
                        ),
                        Text(
                          "LOADING...",
                          style: TextStyle(fontSize: 40),
                        )
                      ],
                    );
                  }
                },
              )
            ],
          ),
        ));
  }
}
