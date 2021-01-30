import 'package:bloc_pattern/bloc_pattern.dart';
import "package:collection/collection.dart";
import 'package:Fluttaxi/src/entity/entities.dart';
import 'package:Fluttaxi/src/infra/help/chart.dart';
import 'package:random_color/random_color.dart';
import 'package:rxdart/rxdart.dart';

import '../../provider.dart';

class TravelDriverBloc extends BlocBase {
  final BehaviorSubject<List<Emergencias>> _listViagensController =
      BehaviorSubject<List<Emergencias>>.seeded(List<Emergencias>());

  Stream<List<Emergencias>> get listViagensFlux => _listViagensController.stream;

  Sink<List<Emergencias>> get listViagensEvent => _listViagensController.sink;

  final BehaviorSubject<List<CharPieFlutter>> _listChartLocalizacaoController =
  BehaviorSubject<List<CharPieFlutter>>.seeded(List<CharPieFlutter>());

  Stream<List<CharPieFlutter>> get listChartLocalizacaoFlux =>
      _listChartLocalizacaoController.stream;

  Sink<List<CharPieFlutter>> get listChartLocalizacaoEvent =>
      _listChartLocalizacaoController.sink;

  final BehaviorSubject<List<CharPieFlutter>> _listChartIdadeController =
  BehaviorSubject<List<CharPieFlutter>>.seeded(List<CharPieFlutter>());

  Stream<List<CharPieFlutter>> get listChartIdadeFlux =>
      _listChartIdadeController.stream;

  Sink<List<CharPieFlutter>> get listChartIdadeEvent =>
      _listChartIdadeController.sink;

  final BehaviorSubject<List<Emergencias>> _chartViagensByIdadeController =
  BehaviorSubject<List<Emergencias>>.seeded(List<Emergencias>());

  Stream<List<Emergencias>> get chartViagensByIdadeFlux =>
      _chartViagensByIdadeController.stream;

  Sink<List<Emergencias>> get chartViagensByIdadeEvent =>
      _chartViagensByIdadeController.sink;

  ViagemService _viagemService;
  MotoristaService _motoristaService;

  TravelDriverBloc() {
    _viagemService = new ViagemService();
    _motoristaService = new MotoristaService();
  }

  loadViagem() async {
    Motorista motorista = await _motoristaService.getCustomerStorage();
    List<Emergencias> listViagem =
    await _viagemService.getViagensByMotorista(motorista.Id);
    if (listViagem == null) listViagem = List<Emergencias>();

    listViagensEvent.add(listViagem);
  }

  loadChartByIdade(List<Emergencias> listViagem) async {
    RandomColor _randomColor = RandomColor();
    List<CharPieFlutter> chartPie = List<CharPieFlutter>();
    groupBy((listViagem.map((r) => r.toJson())),
            (obj) => (obj['PassageiroEntity']['Idade']).toString()).forEach((
        key, itens) {
      chartPie.add(CharPieFlutter(
          itens.length.toDouble(), '$key anos', _randomColor.randomColor()));
    });

    listChartIdadeEvent.add(chartPie);
  }

  loadChartByLocalizacao(List<Emergencias> listViagem) async {
    RandomColor _randomColor = RandomColor();

    List<CharPieFlutter> chartPie = List<CharPieFlutter>();
    groupBy((listViagem.map((r) => r.toJson())),
            (obj) => obj['DestinoEndereco']).forEach((key, itens) {
      chartPie.add(CharPieFlutter(
          itens.length.toDouble(), key, _randomColor.randomColor()));
    });

    listChartLocalizacaoEvent.add(chartPie);
  }

  loadChar() async {
    Motorista motorista = await _motoristaService.getCustomerStorage();
    List<Emergencias> listViagem =
    await _viagemService.getViagensByMotorista(motorista.Id);
    loadChartByIdade(listViagem);
    loadChartByLocalizacao(listViagem);
  }

  @override
  void dispose() {
    _listViagensController?.close();
    _chartViagensByIdadeController?.close();
    _listChartIdadeController?.close();
    _listChartLocalizacaoController?.close();
    super.dispose();
  }
}
