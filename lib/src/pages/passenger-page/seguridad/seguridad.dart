import 'package:Fluttaxi/src/entity/viagem.entity.dart';
import 'package:Fluttaxi/src/pages/passenger-page/home/home.page.dart';
import 'package:Fluttaxi/src/pages/passenger-page/notifications/notifications.dart';
import 'package:flutter/material.dart';


import '../../pages.dart';

class Seguridad extends StatefulWidget{
  @override
  _Seguridad createState() => new _Seguridad();
}

class _Seguridad extends State<Seguridad>{
  GlobalKey<ScaffoldState> _scaffoldKey;
  bool _value1 = false;
  bool _value2 = false;
  bool _value3 = false;
  bool _value4 = false;
  bool _value5 = false;
  bool _value6 = false;
  bool _value7 = false;
  bool _value8 = false;
  bool _value9 = false;
  Emergencias viagem;
  String texto='';

  //we omitted the brackets '{}' and are using fat arrow '=>' instead, this is dart syntax
  void _value1Changed(bool value) => setState(() => _value1 = value);
  void _value2Changed(bool value) => setState(() => _value2 = value);
  void _value3Changed(bool value) => setState(() => _value3 = value);
  void _value4Changed(bool value) => setState(() => _value4 = value);
  void _value5Changed(bool value) => setState(() => _value5 = value);
  void _value6Changed(bool value) => setState(() => _value6 = value);
  void _value7Changed(bool value) => setState(() => _value7 = value);
  void _value8Changed(bool value) => setState(() => _value8 = value);
  void _value9Changed(bool value) => setState(() => _value9 = value);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Seguridad Ciudadana'),
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: new SingleChildScrollView(
        padding: new EdgeInsets.all(32.0),
        child: new Center(
          child: new Column(
            children: <Widget>[
              new CheckboxListTile(
                value: _value1,
                onChanged: _value1Changed,
                title: new Text('Abuso Sexual'),
                //controlAffinity: ListTileControlAffinity.leading,
                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value2,
                onChanged: _value2Changed,
                title: new Text('Maltrato Infantil'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value3,
                onChanged: _value3Changed,
                title: new Text('Explotación Infantil'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value4,
                onChanged: _value4Changed,
                title: new Text('Maltrato contra la mujer'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value5,
                onChanged: _value5Changed,
                title: new Text('Maltrato Adulto Mayor'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value6,
                onChanged: _value6Changed,
                title: new Text('Maltrato LGTBI'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value7,
                onChanged: _value7Changed,
                title: new Text('Violencia Intrafamiliar'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value7,
                onChanged: _value7Changed,
                title: new Text('Racismo'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              new CheckboxListTile(
                value: _value7,
                onChanged: _value7Changed,
                title: new Text('Maltrato Animal'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.green,
              ),
              RaisedButton(

                child: Text("REPORTAR"),
                textColor: Colors.white,
                color: Colors.green,
                onPressed: _showAlertDialog,
              )
            ],

          ),

        ),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
        context: context,
        builder: (buildcontext) {
          return AlertDialog(
            title: Text("¡Alerta!"),
            content: Text("Una vez que continue, las autoridades se pondrán a su disposición, por lo que no puede cancelar la operación"),
            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar", style: TextStyle(color: Colors.green),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Proseguir", style: TextStyle(color: Colors.green),),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                    //return Notifications();
                  }));
                },
              ),
            ],
          );
        }
    );
  }
}