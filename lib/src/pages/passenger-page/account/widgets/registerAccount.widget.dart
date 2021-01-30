import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:Fluttaxi/src/infra/infra.dart';
import 'package:Fluttaxi/src/provider/provider.dart';

import '../../../pages.dart';

class RegisterAccount extends StatefulWidget {
  LoadingBloc _baseBloc;
  GlobalKey<ScaffoldState> _scaffoldLoginKey;

  RegisterAccount(this._baseBloc, this._scaffoldLoginKey);

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  final FocusNode focusPassword = FocusNode();
  final FocusNode focusEmail = FocusNode();
  final FocusNode focusName = FocusNode();
  final FocusNode focusIdade = FocusNode();
  //final FocusNode focusTipoDocumento = FocusNode();
  final FocusNode focusCedula = FocusNode();
  final FocusNode focusSangre = FocusNode();
  final FocusNode focusOcupacion = FocusNode();
  final FocusNode focusDireccion = FocusNode();
  final FocusNode focusBarrio = FocusNode();
  final FocusNode focusCelular = FocusNode();
  AuthPassengerBloc _auth;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  String dropdownValue = 'Cedula de ciudadania';
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController signupEmailController = new TextEditingController();
  //TextEditingController signupTipoDocumentoController = new TextEditingController();
  TextEditingController signupCedulaController = new TextEditingController();
  TextEditingController signupSangreController = new TextEditingController();
  TextEditingController signupOcupacionController = new TextEditingController();
  TextEditingController signupDireccionController = new TextEditingController();
  TextEditingController signupBarrioController = new TextEditingController();
  TextEditingController signupCelularController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupIdadeController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  @override
  void initState() {
    _auth = AuthPassengerBloc();
    super.initState();
  }

  @override
  void dispose() {
    focusPassword?.dispose();
    focusEmail?.dispose();
    focusName?.dispose();
    //focusTipoDocumento?.dispose();
    focusCedula?.dispose();
    focusSangre?.dispose();
    //focusOcupacion?.dispose();
    focusDireccion?.dispose();
    focusBarrio?.dispose();
    focusCelular?.dispose();

    super.dispose();
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  void _registerWithEmailPass(BuildContext contect) {
    if (_formKey.currentState.validate()) {
      widget._baseBloc.loadingStatusEvent.add(true);

      _auth
          .registerWithEmailPassword(
              name: signupNameController.value.text,
              email: signupEmailController.value.text,
              password: signupPasswordController.value.text,
              idade: int.parse(signupIdadeController.value.text),
              tipoDocumento: dropdownValue,
              cedula: signupCedulaController.value.text,
              //tipoSangre: signupSangreController.value.text,
              //ocupacion: signupOcupacionController.value.text,
              direccion: signupDireccionController.value.text,
              barrio: signupBarrioController.value.text,
              celular: signupCelularController.value.text)
          .then((r) {
        widget._baseBloc.loadingStatusEvent.add(false);
        _functionResetFields();
        ShowSnackBar.build(
            widget._scaffoldLoginKey, 'Usuario creado exitosamente', context);
        Timer(Duration(seconds: 3), () {
          // 5s over, navigate to a new page
          NavigationPagesPassageiro.goToHome(context);
        });


        // Navigator.of(context)
        //     .push(MaterialPageRoute(builder: (context) {
        //   return Defensa();
        //   //return Container();
        // }));
      }, onError: (ex) {
        widget._baseBloc.loadingStatusEvent.add(false);
        switch (ex.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            ShowSnackBar.build(widget._scaffoldLoginKey,
                'El correo ya fue registrado anteriormente', context);
            break;
          case "ERROR_INVALID_EMAIL":
            ShowSnackBar.build(
                widget._scaffoldLoginKey, 'Correo inválido', context);

            break;
          default:
            ShowSnackBar.build(widget._scaffoldLoginKey,
                'Disculpas, ocurrió un error', context);
            break;
        }
      });
    }
  }

  void _functionResetFields() {
    signupPasswordController.text = "";
    signupEmailController.text = "";
    signupNameController.text = "";
    signupIdadeController.text = "";
    //signupTipoDocumentoController.text = "";
    signupCedulaController.text = "";
    //signupSangreController.text = "";
    //signupOcupacionController.text = "";
    signupDireccionController.text = "";
    signupBarrioController.text = "";
    signupCelularController.text = "";
    signupConfirmPasswordController.text = "";
    setState(() {
      _formKey = GlobalKey<FormState>();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        //padding: EdgeInsets.only(top: 3.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: 300.0,
                    height: 330.0,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            focusNode: focusName,
                            controller: signupNameController,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("user"),
                                color: Colors.black,
                              ),
                              labelText: "Nombre Completo",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                top: 0.0, bottom: 0.0, left: 25.0, right: 80.0),
                            child: DropdownButton<String>(

                              //icon: Icon(Icons.arrow_downward),
                              value: dropdownValue,
                              iconSize: 24,
                              elevation: 16,
                              style: TextStyle(fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 16.0,
                                  color: Colors.black),

                              onChanged: (String newValue) {
                                setState(() {
                                  dropdownValue = newValue;
                                });
                              },
                              items: <String>[
                                'Cedula de ciudadania',
                                'Cedula extranjeria',
                                'Tarjeta de identidad'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            )),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            focusNode: focusCedula,
                            controller: signupCedulaController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("vcard"),
                                color: Colors.black,
                              ),
                              labelText: "Numero de documento",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        /*Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            focusNode: focusSangre,
                            controller: signupSangreController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("plus"),
                                color: Colors.black,
                              ),
                              labelText: "Tipo de sangre",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),*/
                        /*Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            focusNode: focusOcupacion,
                            controller: signupOcupacionController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("laptop"),
                                color: Colors.black,
                              ),
                              labelText: "Ocupacion",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),*/
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            focusNode: focusDireccion,
                            controller: signupDireccionController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("building"),
                                color: Colors.black,
                              ),
                              labelText: "Direccion",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            focusNode: focusBarrio,
                            controller: signupBarrioController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("university"),
                                color: Colors.black,
                              ),
                              labelText: "Barrio",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Este campo no puede estar vacio";
                              }
                              return null;
                            },
                            focusNode: focusCelular,
                            controller: signupCelularController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("mobile-phone"),
                                color: Colors.black,
                              ),
                              labelText: "Celular",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) =>
                                HelpService.validateEmail(value),
                            focusNode: focusEmail,
                            controller: signupEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("envelope"),
                                color: Colors.black,
                              ),
                              labelText: "Correo electrónico",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 5.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            focusNode: focusIdade,
                            controller: signupIdadeController,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Debes poner tu edad";
                              }
                              return null;
                            },
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("birthday-cake"),
                                color: Colors.black,
                              ),
                              labelText: "Edad",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Introduce una contraseña";
                              }

                              if (value !=
                                  signupConfirmPasswordController.text) {
                                return "La contraseña no coincide";
                              }
                              return null;
                            },
                            focusNode: focusPassword,
                            controller: signupPasswordController,
                            obscureText: _obscureTextSignup,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("lock"),
                                color: Colors.black,
                              ),
                              labelText: "Contraseña",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  FontAwesome.getIconData("eye"),
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextField(
                            controller: signupConfirmPasswordController,
                            obscureText: _obscureTextSignupConfirm,
                            onTap: _toggleSignupConfirm,
                            style: TextStyle(
                                fontFamily: FontStyleApp.fontFamily(),
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily()),
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesome.getIconData("lock"),
                                color: Colors.black,
                              ),
                              labelText: "Confirmar",
                              hintStyle: TextStyle(
                                  fontFamily: FontStyleApp.fontFamily(),
                                  fontSize: 17.0),
                              suffixIcon: GestureDetector(
                                onTap: () => {},
                                child: Icon(
                                  FontAwesome.getIconData("eye"),
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 50.0,
                          //color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 300.0),
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0.0, 0.3),
                            blurRadius: 1.0,
                          ),
                        ],
                        gradient: ColorsStyle.getColorBotton()),
                    child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: Color(0xFFFFFFFF),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            "REGISTRARSE",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        onPressed: () => _registerWithEmailPass(context))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
