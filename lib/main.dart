import 'package:flutter/material.dart';
import 'package:mppt_esp32/screen/dashboard_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 MPPT',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomepage(title: 'MPPT'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomepage extends StatelessWidget {
  MyHomepage({Key key, this.title}) : super(key: key);
  final String title;
  //Method

  @override
  Widget build(BuildContext context) {
    return DashboardScreen();
  }
}

//โซล่าเซลล์
class Solacell extends StatelessWidget {
  Solacell({Key key, this.name, this.volt, this.image, this.amp, this.watt})
      : super(key: key);
  final String name;
  final double volt;
  final String image;
  final double amp;
  final double watt;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 200,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Image.asset("images/" + image),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(this.name,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text("Voltage : " + " V",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          Text("Current : " + " A",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          Text("Power : " + " W",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow)),
                        ],
                      )))
            ])));
  }
}

//แบตเตอรี่
class Battery extends StatelessWidget {
  Battery({
    Key key,
    this.name,
    this.volt,
    this.image,
    this.charge,
    this.percent,
  }) : super(key: key);
  final String name;
  final double volt;
  final String image;
  final String charge;
  final double percent;
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(2),
        height: 200,
        child: Card(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              Image.asset("images/" + image),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(this.name,
                              style: TextStyle(
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue)),
                          Text("Voltage : " + " V",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green)),
                          Text("Charging type : ",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red)),
                          Text("% : ",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                        ],
                      )))
            ])));
  }
}

//สวิตซ์เลื่อนเปิดปิด
class SwitchWidget extends StatefulWidget {
  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();
}

class SwitchWidgetClass extends State {
  bool switchControl = false;
  var textHolder = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Charge is ON';
      });
      print('Charge is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Charge is OFF';
      });
      print('Charge is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: switchControl,
            activeColor: Colors.blue,
            activeTrackColor: Colors.green,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          )),
      Text(
        '$textHolder',
        style: TextStyle(fontSize: 20),
      )
    ]);
  }
}
