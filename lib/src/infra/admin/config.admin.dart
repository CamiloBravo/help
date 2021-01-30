import 'package:Fluttaxi/src/entity/entities.dart';

/*<key,urlfirebase>*/
final dabaBaseTables = <String, String>{
  'passageiro': 'Usuario',
  'motorista': 'Autoridad',
  'viagem': 'Emergencias',
  'relatorio': 'Relatorio',
  'veiculo': 'Veiculo',
};

final Ambiente configAmbiente = Ambiente.Passenger;

final double valorKm = 5;

final keyGoogle = 'AIzaSyBrK4ZjpUe0qMqgOkZWfYC4Vt_nJUOcA7Y';