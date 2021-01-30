import 'package:Fluttaxi/src/entity/viagem.entity.dart';
import 'package:Fluttaxi/src/pages/passenger-page/home/home.page.dart';
import 'package:flutter/material.dart';


import '../../pages.dart';

class Bomberos extends StatefulWidget{
  @override
  _Bomberos createState() => new _Bomberos();
}

class _Bomberos extends State<Bomberos>{
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
        title: new Text('Bomberos'),
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
                title: new Text('Incendio Vivienda'),
                //controlAffinity: ListTileControlAffinity.leading,
                secondary: new Icon(Icons.home),
                activeColor: Colors.red,
              ),
              new CheckboxListTile(
                value: _value2,
                onChanged: _value2Changed,
                title: new Text('Incendio Automóvil'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.directions_car),
                activeColor: Colors.red,
              ),
              new CheckboxListTile(
                value: _value3,
                onChanged: _value3Changed,
                title: new Text('Incendio Forestal'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.landscape),
                activeColor: Colors.red,
              ),
              new CheckboxListTile(
                value: _value4,
                onChanged: _value4Changed,
                title: new Text('Rescate de Personas'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.accessibility),
                activeColor: Colors.red,
              ),
              new CheckboxListTile(
                value: _value5,
                onChanged: _value5Changed,
                title: new Text('Rescate Vehicular'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.directions_car),
                activeColor: Colors.red,
              ),
              new CheckboxListTile(
                value: _value6,
                onChanged: _value6Changed,
                title: new Text('Rescate de estructuras colapsadas'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.add_alert),
                activeColor: Colors.red,
              ),
              new CheckboxListTile(
                value: _value7,
                onChanged: _value7Changed,
                title: new Text('Inspección de Riesgo'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.dialer_sip),
                activeColor: Colors.red,
              ),
              new CheckboxListTile(
                value: _value8,
                onChanged: _value8Changed,
                title: new Text('Primeros Auxilios'),
                //controlAffinity: ListTileControlAffinity.leading,

                secondary: new Icon(Icons.add_comment),
                activeColor: Colors.red,
              ),
              RaisedButton(

                child: Text("REPORTAR"),
                textColor: Colors.white,
                color: Colors.redAccent,
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
            actions: <Widget>[
              FlatButton(
                child: Text("Cancelar", style: TextStyle(color: Colors.red),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text("Proseguir", style: TextStyle(color: Colors.red),),
                onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                    return HomePage();
                    //return Container();
                  }));
                },
              ),
            ],
          );
        }
    );
  }
}