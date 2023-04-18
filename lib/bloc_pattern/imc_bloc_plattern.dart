import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:imc_app/bloc_pattern/imc_bloc_pattern_controller.dart';
import 'package:imc_app/bloc_pattern/imc_bloc_pattern_state.dart';
import 'package:intl/intl.dart';

import '../widgets/imc_gauge.dart';

class ImcBlocPlattern extends StatefulWidget {
  const ImcBlocPlattern({Key? key}) : super(key: key);

  @override
  State<ImcBlocPlattern> createState() => _ImcBlocPlatternState();
}

class _ImcBlocPlatternState extends State<ImcBlocPlattern> {
  final controller = ImcBlocPatternController();
  final pesoEC = TextEditingController();
  final alturaEC = TextEditingController();
  var imc = 0.0;
  var formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEC.dispose();
    alturaEC.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC Bloc Pattern'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                StreamBuilder<ImcState>(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      var imc = snapshot.data?.imc ?? 0;
                      return ImcGauge(
                        imc: imc,
                      );
                    }),
                SizedBox(
                  height: 20,
                ),
                StreamBuilder<ImcState>(
                    stream: controller.imcOut,
                    builder: (context, snapshot) {
                      final dataValue = snapshot.data;
                      if (dataValue is ImcStateLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (dataValue is ImcStateError) {
                        return Text(dataValue.message);
                      }
                      return SizedBox.shrink();
                    }),
                TextFormField(
                  controller: pesoEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Peso"),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: "pt_BR",
                        symbol: "",
                        turnOffGrouping: true,
                        decimalDigits: 2),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Campo obrigatório";
                    }
                  },
                ),
                TextFormField(
                  controller: alturaEC,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Altura"),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                        locale: "pt_BR",
                        symbol: "",
                        turnOffGrouping: true,
                        decimalDigits: 2),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Campo obrigatório";
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      var formValid = formkey.currentState?.validate() ?? false;
                      if (formValid) {
                        var formatter = NumberFormat.simpleCurrency(
                          locale: "pt_BR",
                          decimalDigits: 2,
                        );
                        double peso = formatter.parse(pesoEC.text) as double;
                        double altura =
                            formatter.parse(alturaEC.text) as double;
                        controller.calcularImc(peso: peso, altura: altura);
                      }
                    },
                    child: Text("Calcule IMC"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
