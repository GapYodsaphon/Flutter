import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;




class covidToday{
  static Future<todayCase> covid() async
  {
    var url = "https://covid19.th-stat.com/api/open/today";
    var response = await http.get(url);
    Map map=json.decode(response.body);
    todayCase today = todayCase.fromJson(map);
    return today;
  }
}
class todayCase {
  int confirmed;
  int recovered;
  int hospitalized;
  int deaths;
  int newConfirmed;
  int newRecovered;
  int newHospitalized;
  int newDeaths;
  String updateDate;
  String source;
  String devBy;
  String severBy;

  todayCase(
      {
        this.confirmed,
        this.recovered,
        this.hospitalized,
        this.deaths,
        this.newConfirmed,
        this.newRecovered,
        this.newHospitalized,
        this.newDeaths,
        this.updateDate,
        this.source,
        this.devBy,
        this.severBy});

  todayCase.fromJson(Map<String, dynamic> json) {
    confirmed = json['Confirmed'];
    recovered = json['Recovered'];
    hospitalized = json['Hospitalized'];
    deaths = json['Deaths'];
    newConfirmed = json['NewConfirmed'];
    newRecovered = json['NewRecovered'];
    newHospitalized = json['NewHospitalized'];
    newDeaths = json['NewDeaths'];
    updateDate = json['UpdateDate'];
    source = json['Source'];
    devBy = json['DevBy'];
    severBy = json['SeverBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Confirmed'] = this.confirmed;
    data['Recovered'] = this.recovered;
    data['Hospitalized'] = this.hospitalized;
    data['Deaths'] = this.deaths;
    data['NewConfirmed'] = this.newConfirmed;
    data['NewRecovered'] = this.newRecovered;
    data['NewHospitalized'] = this.newHospitalized;
    data['NewDeaths'] = this.newDeaths;
    data['UpdateDate'] = this.updateDate;
    data['Source'] = this.source;
    data['DevBy'] = this.devBy;
    data['SeverBy'] = this.severBy;
    return data;
  }
}

void main() {
  runApp(Gappe());
}

class Gappe extends StatelessWidget {
  var _title ="GapysApp";



  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "_title",

      home: Scaffold(

        appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),

          child:   AppBar(
            elevation: 5,
            title: Text(_title),
            backgroundColor: Colors.orange,
          ),
        ),
        drawer: drawerSections,
        body: ListView(children: <Widget>[
          Row(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisSize: MainAxisSize.max,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Container(
                 width: 200,
                 height: 50,
                 child: Card(
                   child: Center(child:Text('รายงานสถานการณ์วันนี้',style: TextStyle(fontWeight: FontWeight.bold), ) ),
                 ),
               )
            ]
        ),
          headerSections,dateData(),
        ],
      ),
    ),);
  }
}

Drawer drawerSections = Drawer(
  child: ListView(

    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        child: Text("Menu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        curve: Curves.linearToEaseOut,
        decoration: BoxDecoration(
            color: Colors.blueGrey
        ),
      ),
      ListTile(

        title: IconButton(
          icon: Icon(Icons.today),
          onPressed: (){

          },
        ),


      ),
      ListTile(
        title: Text("sections 2"),
        onTap:(){


        },
      )
    ],
  ),


);



Widget headerSections =Column(
    mainAxisAlignment: MainAxisAlignment.center,
  children: <Widget>[
      newConfirm(),
      deathConfirm(),
      totalCase(),
      recover(),
      hospitalStay(),


  ],
);







class newConfirm extends StatefulWidget {
  @override
  _newConfirmState createState() => _newConfirmState();
}

class _newConfirmState extends State<newConfirm> {
  @override
  Widget build(BuildContext context) {
   return Container(
          width: 200,
          height: 100,


          child: Card(
              child:Column(
                children: <Widget>[
                  FutureBuilder(
                    future: covidToday.covid(),
                    builder: (context,covid){
                      if(covid.hasData){
                        todayCase msg = covid.data;
                        var newconfirm = msg.newConfirmed;
                        // ignore: missing_return, missing_return
                        return Center(child: Text('ผู้ป่วยเพิ่มมาใหม่ : ${newconfirm}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),) ;
                      }
                      else
                        return Text("wait");
                    },
                  ),
                  Icon(Icons.accessibility_new,size: 50,color: Colors.red,)

                ],
              )


          ),
        );

  }
  
}

class dateData extends StatefulWidget {
  @override
  _dateDataState createState() => _dateDataState();
}

class _dateDataState extends State<dateData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child:Column(
          children: <Widget>[
            FutureBuilder(
              future: covidToday.covid(),
              builder: (context,covid){
                if(covid.hasData){
                  todayCase msg = covid.data;
                  print(msg.toJson());
                  var date= msg.updateDate;
                  var source = msg.source;
                  // ignore: missing_return, missing_return
                  return Center(child: Text('ข้อมูลวันที่ : ${date}\nข้อมูลจาก ${source}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),) ;
                }
                else
                  return Text("wait");
              },
            ),


          ],
        )


    ),);
  }
}


class deathConfirm extends StatefulWidget {
  @override
  _deathConfirmState createState() => _deathConfirmState();
}

class _deathConfirmState extends State<deathConfirm> {
  @override
  Widget build(BuildContext context) {
    return
        Container(

          width: 200,
          height: 100,

          child: Card(
              child:Column(
                children: <Widget>[
                  FutureBuilder(
                    future: covidToday.covid(),
                    builder: (context,covid){
                      if(covid.hasData){
                        todayCase msg = covid.data;
                        int deathcf = msg.newDeaths;
                        int death   = msg.deaths;
                        // ignore: missing_return, missing_return
                        return Center(child: Text('ผู้เสียชีวิตตวันนี้ : ${deathcf}\nยอดผู้เสียชีวิต ${death}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),) ;
                      }
                      else
                        return Text("wait");
                    },
                  ),
                  Icon(Icons.airline_seat_flat,size: 50,color: Colors.red,)

                ],
              )


          ),
        );

}
}

class totalCase extends StatefulWidget {
  @override
  _totalCaseState createState() => _totalCaseState();
}

class _totalCaseState extends State<totalCase> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,

      child: Card(

          child:Column(
            children: <Widget>[
              FutureBuilder(
                future: covidToday.covid(),
                builder: (context,covid){
                  if(covid.hasData){
                    todayCase msg = covid.data;
                    int confirm = msg.confirmed;

                    return Center(child: Text('ทั้งหมด : ${confirm}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),) ;
                  }
                  else
                    return Text("wait");
                },
              ),
              Icon(Icons.done_all,size: 50,color: Colors.red,)

            ],
          )


      ),
    );
  }
}
// ignore: camel_case_types
class recover extends StatefulWidget {
  @override
  _recoverState createState() => _recoverState();
}

class _recoverState extends State<recover> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,

      child: Card(
          child:Column(
            children: <Widget>[
              FutureBuilder(
                future: covidToday.covid(),
                builder: (context,covid){
                  if(covid.hasData){
                    todayCase msg = covid.data;
                    int recovered = msg.recovered;
                    // ignore: missing_return, missing_return
                    return Center(child: Text('หายแล้ว : ${recovered}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),) ;
                  }
                  else
                    return Text("wait");
                },
              ),
              Icon(Icons.local_hospital,size: 50,color: Colors.red,)

            ],
          )


      ),
    );
  }
}


class hospitalStay extends StatefulWidget {
  @override
  _hospitalStayState createState() => _hospitalStayState();
}

class _hospitalStayState extends State<hospitalStay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,

      child: Card(
          child:Column(
            children: <Widget>[
              FutureBuilder(
                future: covidToday.covid(),
                builder: (context,covid){
                  if(covid.hasData){
                    todayCase msg = covid.data;
                    int hospital = msg.hospitalized;
                    int recovertoday = msg.newRecovered;
                    // ignore: missing_return, missing_return
                    return Center(child: Text('กำลังรักษา ${hospital}\n หายวันนี้ ${recovertoday}',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),) ;
                  }
                  else
                    return Text("wait");
                },
              ),
              Icon(Icons.favorite,size: 50,color: Colors.red,)
            ],
          )

      ),
    );
  }
}







