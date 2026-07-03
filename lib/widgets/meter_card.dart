import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class MeterCard extends StatelessWidget {
  const MeterCard({
    super.key,
    required this.displayRate,
    required this.unitText,
  });

  final double displayRate;
  final String unitText;

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: [
        RadialAxis(
          radiusFactor: 0.99,
          minorTicksPerInterval: 1,
          tickOffset: 2,
          useRangeColorForAxis: true,
          interval: 5,
          minimum: 0,
          maximum: 100,
          axisLabelStyle: GaugeTextStyle(
            color: const Color.fromARGB(255, 211, 18, 18),
          ),
          ranges: [
            GaugeRange(
              color: Color.fromARGB(255, 30, 244, 255),
              startValue: 0,
              endValue: 100,
              startWidth: 10,
              endWidth: 10,
            ),
          ],
          pointers: [
            RangePointer(
              value: displayRate,
              width: 10,
              color: Colors.orange,
              enableAnimation: true,
            ),
            NeedlePointer(
              value: displayRate,
              enableAnimation: true,
              needleColor: Colors.orange,
              tailStyle: TailStyle(
                color: Colors.white,
                borderWidth: 0.1,
                borderColor: Colors.blue,
              ),
              knobStyle: KnobStyle(
                color: Colors.white,
                borderColor: Colors.red,
                borderWidth: 0.01,
              ),
            ),
          ],
          annotations: [
            GaugeAnnotation(
              widget: Text(
                displayRate.toStringAsFixed(2) + unitText,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              angle: 85,
              positionFactor: 0.7,
            ),
          ],
        ),
      ],
    );
  }
}
