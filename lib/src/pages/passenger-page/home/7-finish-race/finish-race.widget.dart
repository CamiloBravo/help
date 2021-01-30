import 'dart:async';

import 'package:Fluttaxi/src/infra/admin/roteamento-passageiro.dart';
import 'package:Fluttaxi/src/pages/driver-page/shared/tab/hometab.page.dart';
import 'package:Fluttaxi/src/pages/passenger-page/pages.dart';
import 'package:Fluttaxi/src/pages/passenger-page/police/police.dart';
import 'package:Fluttaxi/src/provider/provider.dart';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:Fluttaxi/src/entity/entities.dart';
import 'package:Fluttaxi/src/provider/blocs/blocs.dart';

import '../../../pages.dart';

class FinishRaceWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey;

  FinishRaceWidget(this.scaffoldKey);

  HomePassageiroBloc _homeBloc = BlocProvider.getBloc<HomePassageiroBloc>();
  BasePassageiroBloc _baseBloc = BlocProvider.getBloc<BasePassageiroBloc>();
  BaseDriverBloc _authBase = BlocProvider.getBloc<BaseDriverBloc>();
  ViagemService _viagemService = new ViagemService();

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2000), () async {
      ShowSnackBar.build(
          scaffoldKey, 'El policia ha llegado', context);

      //_baseBloc.cancelarCorrida();
      //await _baseBloc.orchestration();
      Timer(Duration(seconds: 3), () async {
        // 5s over, navigate to a new page
        Emergencias viagem = await _authBase.viagemFlux.first;
        viagem.Status = TravelStatus.Canceled;
        await _viagemService.save(viagem);
        _homeBloc.stepProcessoEvent.add(StepPassengerHome.Start);
        _baseBloc.orchestration();
        NavigationPagesPassageiro.goToHome(context);
      });
      //NavigationPagesPassageiro.goToHome(context);
    });

    return Container(height: 1, width: 1);
  }
}
