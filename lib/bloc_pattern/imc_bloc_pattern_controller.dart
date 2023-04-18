import 'dart:async';
import 'dart:math';

import 'package:imc_app/bloc_pattern/imc_bloc_pattern_state.dart';

class ImcBlocPatternController {
  final _imcStreamController = StreamController<ImcState>.broadcast()
    ..add(ImcState(imc: 0));
  Stream<ImcState> get imcOut => _imcStreamController.stream;
  // Sink<ImcState> get imcIn => _imcStreamController.sink; (essa linha de comando tem a mesma função da linha acima)

  Future<void> calcularImc(
      {required double peso, required double altura}) async {
    try {
      _imcStreamController.add(ImcStateLoading());
      await Future.delayed(Duration(seconds: 1));
      final imc = peso / pow(altura, 2);
      _imcStreamController.add(ImcState(imc: imc));
    } on Exception catch (e) {
      _imcStreamController.add(ImcStateError(message: "Erro ao calcular imc"));
    }
  }

  void dispose() {
    _imcStreamController.close();
  }
}
