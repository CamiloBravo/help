import 'package:Fluttaxi/src/infra/infra.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:Fluttaxi/src/entity/entities.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../provider.dart';

class AuthPassengerBloc extends BlocBase {
  GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PassageiroService _customerService = PassageiroService();
  final ViagemService _viagemService = ViagemService();
  final _userInfoController = BehaviorSubject<Passageiro>();
  int edad = 0;
  String nombre = '';
  String tipo = '';
  String documento = '';
  String sangre = '';
  String ocupa = '';
  String dir = '';
  String barrio = '';
  String celular = '';

  Observable<Passageiro> get userInfoFlux => _userInfoController.stream;

  Sink<Passageiro> get userInfoEvent => _userInfoController.sink;

  Passageiro get userValue => _userInfoController.value;

  final BehaviorSubject<bool> _startController = new BehaviorSubject<bool>();

  Observable<bool> get startFlux => _startController.stream;

  Sink<bool> get startEvent => _startController.sink;
  PassageiroService _passageiroService;

  AuthPassengerBloc() {
    _passageiroService = PassageiroService();
    _validaPage();
  }

  _validaPage() async {
    Passageiro passageiro = await _passageiroService.getCustomerStorage();
    userInfoEvent.add(passageiro);
    startEvent.add(passageiro == null);

    if (passageiro != null)
      await _viagemService.cancelAllViagensPassageiroAberta(passageiro.Id);
  }

  Future<void> refreshAuth() async {
    Passageiro passageiro = await _passageiroService.getCustomerStorage();
    userInfoEvent.add(passageiro);
  }

  Future<void> addPassageiroAuth(Passageiro passageiro) async {
    _passageiroService.setStorage(passageiro);
    await _passageiroService.save(passageiro);
    await refreshAuth();
  }

/*  Future<void> signWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)).user;

      final passageiro = Passageiro(
          Idade: 0,
          Email: user.email,
          Foto: Imagem(Url: user.photoUrl, IndicaOnLine: true),
          Nome: user.displayName,
          Id: user.uid);

      await _customerService.verificyExistsByEmailAndSave(passageiro);
      userInfoEvent.add(passageiro);
      await _customerService.setStorage(passageiro);
    } on PlatformException catch (ex) {
      throw ex;
    } catch (ex) {
      throw ex;
    }
  }*/

  Future<bool> signWithEmailPassword({
    @required String email,
    @required String password,
  }) async {
    try {
      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      if (user == null) return false;

//      Firestore.instance.collection("Usuario").getDocuments().then((querySnapshot) {
//        querySnapshot.documents.forEach((result) {
//          print(result.data);
//        });
//      });

      //var firebaseUser = await FirebaseAuth.instance.currentUser();

//      _passageiroBloc
//          .save(passageiro)
//          .then((r) {
//        _passageiroBloc
//            .setStorage(passageiro);
//        _authBloc
//            .refreshAuth()
//            .then((result) {
//          ShowSnackBar.build(
//              _scaffoldKey,
//              'Edad guardada con éxito',
//              context);
//        });
//      });

      final passageiro = Passageiro(
          Idade: edad,
          Email: user.email,
          Foto: Imagem(
              Url: 'assets/images/usuario/avatar_user.png',
              IndicaOnLine: false),
          Nome: nombre,
          TipoDocumento: tipo,
          Cedula: documento,
          TipoSangre: sangre,
          Ocupacion: ocupa,
          Direccion: dir,
          Barrio: barrio,
          Celular: celular,
          Id: user.uid);

      Firestore.instance
          .collection("Usuario")
          .document(user.uid)
          .get()
          .then((value) {
        edad = value.data["Edad"];
        nombre = value.data["Nombre"];
        tipo = value.data["TipoDocumento"];
        documento = value.data["Cedula"];
        sangre = value.data["TipoSangre"];
        ocupa = value.data["Ocupacion"];
        dir = value.data["Direccion"];
        barrio = value.data["Barrio"];
        celular = value.data["Celular"];

        passageiro.Idade = edad;
        passageiro.Nome = nombre;
        passageiro.TipoDocumento = tipo;
        passageiro.Cedula = documento;
        passageiro.TipoSangre = sangre;
        passageiro.Ocupacion = ocupa;
        passageiro.Direccion = dir;
        passageiro.Barrio = barrio;
        passageiro.Celular = celular;
//        print('La edad is: ' + edad.toString());

        userInfoEvent.add(passageiro);
        _customerService.setStorage(passageiro);
        //print('La edad es: ' + passageiro.Idade.toString());
      });



      return true;
    } on PlatformException catch (ex) {
      throw ex;
    } catch (ex) {
      throw ex;
    }
  }

  Future<void> recoveryPassword({
    @required String email,
  }) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on PlatformException catch (ex) {
      throw ex;
    } catch (ex) {
      throw ex;
    }
  }

  Future<void> registerWithEmailPassword(
      {@required String email,
      @required String password,
      @required String name,
      @required int idade,
      @required String tipoDocumento,
      @required String cedula,
      @required String tipoSangre,
      @required String ocupacion,
      @required String direccion,
      @required String barrio,
      @required String celular}) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      final passageiro = Passageiro(
          Idade: idade,
          Email: user.email,
          Foto: Imagem(
              Url: 'assets/images/usuario/avatar_user.png',
              IndicaOnLine: false),
          Nome: name,
          TipoDocumento: tipoDocumento,
          Cedula: cedula,
          TipoSangre: tipoSangre,
          Ocupacion: ocupacion,
          Direccion: direccion,
          Barrio: barrio,
          Celular: celular,
          Id: user.uid);

      await _customerService.verificyExistsByEmailAndSave(passageiro);

      userInfoEvent.add(passageiro);
      _customerService.setStorage(passageiro);
    } on PlatformException catch (ex) {
      throw ex;
    } catch (ex) {
      throw ex;
    }
  }

  Stream<FirebaseUser> get onAuthStateChanged => _auth.onAuthStateChanged;

  Future<void> signOut() async {
    await _passageiroService.remove();
    return Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _auth.currentUser();
    return currentUser != null;
  }

  @override
  void dispose() {
    _userInfoController?.close();
    _startController?.close();
    super.dispose();
  }
}
