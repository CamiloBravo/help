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
  AuthDriverBloc _auth;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  @override
  void initState() {
    _auth = AuthDriverBloc();
    super.initState();
  }

  @override
  void dispose() {
    focusPassword?.dispose();
    focusEmail?.dispose();
    focusName?.dispose();
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
          password: signupPasswordController.value.text)
          .then((r) {
        widget._baseBloc.loadingStatusEvent.add(false);
        _functionResetFields();
        ShowSnackBar.build(
            widget._scaffoldLoginKey, 'Usuario creado con éxito', context);
      }, onError: (ex) {
        widget._baseBloc.loadingStatusEvent.add(false);
        switch (ex.code) {
          case "ERROR_EMAIL_ALREADY_IN_USE":
            ShowSnackBar.build(
                widget._scaffoldLoginKey, 'Ya existe un usuario con este correo', context);
            break;
          case "ERROR_INVALID_EMAIL":
            ShowSnackBar.build(
                widget._scaffoldLoginKey, 'Correo invalido', context);

            break;
          default:
            ShowSnackBar.build(widget._scaffoldLoginKey,
                'Perdon, ha ocurrido un error inesperado', context);
            break;
        }
      });
    }
  }

  void _functionResetFields() {
    signupPasswordController.text = "";
    signupEmailController.text = "";
    signupNameController.text = "";
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
        padding: EdgeInsets.only(top: 23.0),
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
                    height: 380.0,
                    child: Column(
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
                                return "Campo de nombre vacio";
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
                              labelText: "Nombre completo",
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
                              top: 0.0, bottom: 0.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            validator: (value) {
                              if (value.isEmpty) {
                                return "La constraseña no puede estar vacia!";
                              }

                              if (value !=
                                  signupConfirmPasswordController.text) {
                                return "No coincide la contraseña";
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
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 360.0),
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
