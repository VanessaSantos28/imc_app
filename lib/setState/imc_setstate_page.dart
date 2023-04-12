import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcSetstatePage extends StatelessWidget {
  const ImcSetstatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('IMC SetState  '),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SfRadialGauge(
                axes: [
                  RadialAxis(
                    showAxisLine: false,
                    showLabels: false,
                    showTicks: false,
                    minimum: 12.5,
                    maximum: 45.9,
                    ranges: [],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
