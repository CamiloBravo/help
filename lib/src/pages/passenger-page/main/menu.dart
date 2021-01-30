import 'package:Fluttaxi/src/infra/admin/roteamento-passageiro.dart';
import 'package:Fluttaxi/src/pages/passenger-page/ambulancia/ambulancia.dart';
import 'package:Fluttaxi/src/pages/passenger-page/bomberos/bomberos.dart';
import 'package:Fluttaxi/src/pages/passenger-page/corona/corona.dart';
import 'package:Fluttaxi/src/pages/passenger-page/defensa/defensa.dart';
import 'package:Fluttaxi/src/pages/passenger-page/home/home.page.dart';
import 'package:Fluttaxi/src/pages/passenger-page/notifications/notifications.dart';
import 'package:Fluttaxi/src/pages/passenger-page/police/police.dart';
import 'package:Fluttaxi/src/pages/passenger-page/seguridad/seguridad.dart';
import 'package:Fluttaxi/src/pages/passenger-page/transito/transito.dart';
import 'package:Fluttaxi/src/provider/blocs/passenger-bloc/auth-passageiro.bloc.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:Fluttaxi/src/entity/entities.dart';
import 'package:Fluttaxi/src/infra/help/help.dart';
import 'package:Fluttaxi/src/provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:getwidget/getwidget.dart';

import '../../pages.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.changeDrawer);
  final ValueChanged<BuildContext> changeDrawer;
  @override
  _HomeScreen createState() => new _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool _folded = true;
  TextEditingController _textController = TextEditingController();
  List list = [
    "Choque",
    "Atropellamiento",
    "Volcamiento",
    "Pelea",
    "Robo de vehiculo",
    "Incendio",
    "Atraco",
    "Vecinos ruidosos",
    "Persona herida",
  ];

  String _selectedItemText = "Our Selection Item";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              child: buttonBar(widget.changeDrawer, context),
            ),

            Container(
              width: 220.00,
              height: 220.00,
              child: Image.asset('assets/logoHelpMeT.png'),
            ),

            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Text(
                  //   _selectedItemText,
                  // ),
                  GFSearchBar(
                    searchList: list,
                    searchQueryBuilder: (query, list) {
                      return list
                          .where((item) =>
                          item.toLowerCase().contains(query.toLowerCase()))
                          .toList();
                    },
                    overlaySearchListItemBuilder: (item) {
                      return Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          item,
                          style: const TextStyle(fontSize: 18),
                        ),
                      );
                    },
                    onItemSelected: (item) {
                      // setState(() {
                      //   _selectedItemText = item;
                      // });
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return HomePage();
                        //return Notifications();
                      }));
                    },
                  ),
                ],
              ),
            ),
            // AnimatedContainer(
            //   duration: Duration(milliseconds: 400),
            //   width: _folded ? 56 : 250,
            //   height: 56,
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(32),
            //     color: Colors.white,
            //     boxShadow: kElevationToShadow[6],
            //   ),
            //   child: Row(
            //     children: [
            //       Expanded(
            //         child: Container(
            //           padding: EdgeInsets.only(left: 16),
            //           child: !_folded
            //               ? TextField(
            //                   decoration: InputDecoration(
            //                       hintText: 'Search',
            //                       hintStyle: TextStyle(color: Colors.blue[300]),
            //                       border: InputBorder.none),
            //                   onChanged: (text) {
            //                     text = text.toLowerCase();
            //                     filter(text);
            //                   },
            //                 )
            //               : null,
            //         ),
            //       ),
            //       Container(
            //         child: Material(
            //           type: MaterialType.transparency,
            //           child: InkWell(
            //             borderRadius: BorderRadius.only(
            //               topLeft: Radius.circular(_folded ? 32 : 0),
            //               topRight: Radius.circular(32),
            //               bottomLeft: Radius.circular(_folded ? 32 : 0),
            //               bottomRight: Radius.circular(32),
            //             ),
            //             child: Padding(
            //               padding: const EdgeInsets.all(16.0),
            //               child: Icon(
            //                 _folded ? Icons.search : Icons.close,
            //                 color: Colors.blue[900],
            //               ),
            //             ),
            //             onTap: () {
            //               setState(() {
            //                 _folded = !_folded;
            //               });
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            // Container(
            //   child: Text('LINEAS DE EMERGENCIA'),
            //   alignment: Alignment.center,
            // ),
            //                    Container(
            //                      width: 100.00,
            //                      height: 100.00,
            //                      decoration: BoxDecoration(
            //                          image: DecorationImage(
            //                              image: AssetImage(
            //                                  'assets/images/menu/logo_helpme.jpeg'),
            //                              fit: BoxFit.fill)),
            //
            //                      ),
            Container(
                height: 800,
                child: GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 20,
                  crossAxisCount: 2,
                  children: <Widget>[
                    Container(
                        child: Column(children: <Widget>[
                          Container(
                            width: 78.00,
                            height: 78.00,
                            child: RaisedButton(
                              padding: EdgeInsets.all(0.0),
                              color: Colors.white,
                              child: Image.asset(
                                  'assets/images/menu/coronaicono.png'),
                              onPressed: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return Corona();
                                  //return Container();
                                }));
                              },
                            ),
                            color: Colors.teal[200],
                          ),
                          Container(
                            child: Text('Coronavirus'),
                            padding: EdgeInsets.all(3.0),
                            alignment: Alignment.center,
                          )
                        ])),
                    Container(
                        child: Column(children: <Widget>[
                      Container(
                        width: 78.00,
                        height: 78.00,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0.0),
                          color: Colors.white,
                          child: Image.asset(
                              'assets/images/menu/logo_transito.jpg'),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Transito();
                              //return Container();
                            }));
                          },
                        ),
                        color: Colors.teal[200],
                      ),
                      Container(
                        child: Text('Tránsito'),
                        padding: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                      )
                    ])),
                    Container(
                        child: Column(children: <Widget>[
                      Container(
                        width: 78.00,
                        height: 78.00,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0.0),
                          child: Image.asset(
                              'assets/images/menu/logo_policia.png'),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Police();
                              //return Container();
                            }));
                          },
                        ),
                        color: Colors.teal[100],
                      ),
                      Container(
                        child: Text('Policia'),
                        padding: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                      )
                    ])),
                    Container(
                        child: Column(children: <Widget>[
                      Container(
                        width: 78.00,
                        height: 78.00,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0.0),
                          color: Colors.white,
                          child: Image.asset(
                              'assets/images/menu/logo_bomberos.png'),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Bomberos();
                              //return Container();
                            }));
                          },
                        ),
                        color: Colors.teal[500],
                      ),
                      Container(
                        child: Text('Bomberos'),
                        padding: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                      )
                    ])),
                    Container(
                        child: Column(children: <Widget>[
                      Container(
                        width: 78.00,
                        height: 78.00,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0.0),
                          color: Colors.white,
                          child: Image.asset(
                              'assets/images/menu/logo_seguridad_ciudadana.jpg'),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Seguridad();
                              //return Container();
                            }));
                          },
                        ),
                        color: Colors.teal[600],
                      ),
                      Container(
                        child: Text('Seguridad'),
                        padding: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                      )
                    ])),
                    Container(
                        child: Column(children: <Widget>[
                      Container(
                        width: 78.00,
                        height: 78.00,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0.0),
                          color: Colors.white,
                          child: Image.asset(
                              'assets/images/menu/logo_ambulancia.png'),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Ambulancia();
                              //return Container();
                            }));
                          },
                        ),
                        color: Colors.teal[400],
                      ),
                      Container(
                        child: Text('Ambulancia'),
                        padding: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                      )
                    ])),
                    Container(
                        child: Column(children: <Widget>[
                      Container(
                        width: 78.00,
                        height: 78.00,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0.0),
                          color: Colors.white,
                          child: Image.asset(
                              'assets/images/menu/logo_defensa_civil.png'),
                          onPressed: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return Defensa();
                              //return Container();
                            }));
                          },
                        ),
                        color: Colors.teal[300],
                      ),
                      Container(
                        child: Text('Defensa Civil'),
                        padding: EdgeInsets.all(3.0),
                        alignment: Alignment.center,
                      )
                    ])),
                  ],
                )),
          ],
        ),
      ),
    )));
  }
}

class Display extends StatelessWidget {
  final String text;

  const Display({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(text),
      ),
    );
  }
}
