import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mppt_esp32/widgets/mptt_data_card_widget.dart';
import 'package:mppt_esp32/widgets/mptt_data_overview_widget.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<double> wattList = List<double>();
  List<double> voltageList = List<double>();
  List<double> ampList = List<double>();
  double volt, amp, watt;
  Timer timer;
  FirebaseDatabase _firebaseDatabase = FirebaseDatabase.instance;

  fetchSolarCellData() async {
    DatabaseReference databaseReference = _firebaseDatabase.reference().child("SolaCell");
    await databaseReference.once().then(
      (value) {
        Map<dynamic, dynamic> values = value.value;
        values.forEach(
          (key, value) {
            print("KEY : $key | VALUE : $value");
            voltageList.add(value["Voltage"].toDouble());
            ampList.add(value["Current"].toDouble());
            wattList.add(value["Power"].toDouble());
          },
        );
        setState(() {
          volt = voltageList[0];
          amp = ampList[0];
          watt = wattList[0];
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();

    /* Call for first time */
    fetchSolarCellData();
    /* Call timer to iterable function */
    timer = Timer.periodic(Duration(seconds: 5), (timer) => fetchSolarCellData());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: __dashboardAppbar(),
      drawer: Container(
        width: 250,
        color: Colors.blue,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              MPTTDataOverviewCardWidget(
                icon: Image.asset("images/solacell.png"),
                dataTitle: "SOLAR CELL",
                children: Column(
                  children: [
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "VOLTAGE : $volt V"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "CURRENT : $amp A"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "POWER : $watt W"),
                  ],
                ),
              ),
              MPTTDataOverviewCardWidget(
                icon: Image.asset("images/battery.png"),
                dataTitle: "BATTERY",
                children: Column(
                  children: [
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "VOLTAGE : 00.0 V"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "CHARGE TYPE : ??"),
                    SizedBox(height: 5),
                    MPTTDataCardWidget(dataValue: "PERCENTAGE : %"),
                  ],
                ),
              ),
              // __solarCellWidget(name: "SOLAR CELL", image: "solacell.png"),
            ],
          ),
        ),
      ),
    );
  }

  Widget __dashboardAppbar() => AppBar(
        centerTitle: true,
        title: Text('MPTT ESP32'),
      );
}
