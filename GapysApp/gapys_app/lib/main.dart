import 'package:flutter/material.dart';

void main() {
  runApp(Gappe());
}

class Gappe extends StatelessWidget {
  var _title ="GapysApp";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: "_title",
    home: Scaffold(
      appBar: AppBar(
        title: Text(_title),

      ),
      drawer: drawerSections,
      body: ListView(children: <Widget>[
        headerSections,titleSections,buttonSections,courseSections,rowSections
      ],),
    )
      ,);
  }
}

Widget headerSections =

   Image.network("https://miro.medium.com/max/11400/1*lS9ZqdEGZrRiTcL1JUgt9w.jpeg"
);
Widget titleSections = Padding(padding: EdgeInsets.all(30),

    child : Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Gappe",
                  style: TextStyle(fontWeight: FontWeight.bold),),

              Text("Yodsaphon",
                  style: TextStyle(color: Colors.grey[500]),),
              FavoriteWidget()


            ],
          ),
        ),




    ],
  )
);


int Count = 0;
Widget buttonSections = Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
    _buttonColumn(icon: Icons.favorite ,label: "Love"),
    _buttonColumn(icon: Icons.comment ,label: "Comment"),
    _buttonColumn(icon: Icons.share ,label: "Share"),
    IconButton(icon: Icon(Icons.favorite),
    onPressed: (){

      setState(){
        Count+=1;
      }
        print("click");
      setState();
    },),
      Text('$Count')
  ],
);


Column _buttonColumn({IconData icon,String label})
{
  var icColor = Colors.grey[500];
  return Column(

    children: <Widget>[
      Icon(icon,
        color: icColor,),
      Container(
        margin: EdgeInsets.all(10),
        child: Text(label,
          style:TextStyle(
              color: icColor,
              fontWeight: FontWeight.bold),
        ),
      ),


    ],
  );
}
Widget courseSections = Container(

  height: 600,color: Colors.deepOrangeAccent,

);

Widget rowSections = Stack(
  children: <Widget>[
    Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(80),
          color: Colors.deepOrangeAccent,
          child: Text("test1"),
        ) ,
        Text("test2")
      ],
    )
  ],
);



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
          title: Text("sections 1"),
          onTap: (){
          },
        ),
        ListTile(
          title: Text("sections 2"),
          onTap:(){

          },
        )
      ],
    ),


);



// love button
class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = true ;
  int  _favoriteCount = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(
          icon: _isFavorited?Icon(Icons.favorite):Icon(Icons.favorite_border),

          color: Colors.red,
          onPressed: (){
            setState(() {
              if (_isFavorited) {
                _favoriteCount -=1;
                _isFavorited = false;

              }
              else {
                _favoriteCount +=1;
                _isFavorited = true;
              }
            });},
        ),
        Container(
          margin: EdgeInsets.only(left: 8),
          child: Text('$_favoriteCount',
            style: TextStyle(color: Colors.grey),),
        )
      ],
    );
  }
}
