import 'package:flutter/material.dart';
import 'FrequentZone.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FrequentZoneView(),
    );
  }
}

class FrequentZoneView extends StatefulWidget {
  @override
  _FrequentZoneViewState createState() => _FrequentZoneViewState();
}

class _FrequentZoneViewState extends State<FrequentZoneView> {
  Future<List<FrequentZone>> data;
  @override
  void initState()
  {
    data = fetchPost();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frequent Zone'),),
      body: Center(
      ) ,
    );
  }
}

