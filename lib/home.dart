import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> scaffoldState = new GlobalKey<ScaffoldState>();
  showSnack(String text) {
    scaffoldState.currentState.showSnackBar(SnackBar(
        content: Text(
      text,
      style: TextStyle(color: Colors.green, fontSize: 16),
    )));
  }

  List<String> testList = List.generate(100, (i) => "Item Number : ${i+1}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        appBar: AppBar(
          title: Text('Dismiss List'),
          leading: Icon(Icons.home),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.info_outline,size: 40,color: Colors.redAccent,),
          onPressed: () {
            showSnack("Hello ther, Try to dismiss this list!");
          },
        ),
        body: Container(
            child: ListView(
                children: testList.map((element) {
          return Dismissible(
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.delete,
                color: Colors.red,
                size: 35,
              ),
            ),
            movementDuration: Duration(milliseconds: 1500),
            dismissThresholds: {
              DismissDirection.startToEnd: 1.0,
              DismissDirection.endToStart: 0.7
            },
            key: Key(element),
            child: ListTile(
              leading: FlutterLogo(),
              title: Text(element),
              subtitle: Text("This is item number ($element)"),
            ),
            onDismissed: (direction) {
              setState(() {
                testList.removeAt(testList.indexOf(element));
                showSnack('The Item Number $element is Dismiss ');
              });
            },
          );
        }).toList())));
  }
}
