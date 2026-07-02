import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class SpeedTestUi extends StatefulWidget {
  const SpeedTestUi({super.key});

  @override
  State<SpeedTestUi> createState() => _SpeedTestUiState();
}

class _SpeedTestUiState extends State<SpeedTestUi> {
  //display progress
  double displayProgress = 0.1;
  //rate values
  final double _downloadRate = 0.0;
  final double _uploadRate = 0.0;
  final double displayRate = 0.0;
  bool isServerSelectionInProgress = false;
  String? _isp;
  String? _asp;
  String? _asn;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 10, 35, 73),
      appBar: AppBar(
        title: Text("Speed Test"),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
        backgroundColor: Color.fromARGB(255, 10, 35, 73),
        elevation: 0,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Text(
            "Progress",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(height: 10),
          LinearPercentIndicator(
            percent: displayProgress,
            lineHeight: 18,
            progressColor: Colors.orange,
            center: Text(
              "${displayProgress.toStringAsFixed(1)}%",
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            barRadius: Radius.circular(10),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Download Rate",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Upload Rate",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _downloadRate.toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      _uploadRate.toStringAsFixed(2),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
          SfRadialGauge(
            axes: [
              RadialAxis(
                radiusFactor: 0.85,
                minorTicksPerInterval: 1,
                tickOffset: 3,
                useRangeColorForAxis: true,
                interval: 4,
                minimum: 0,
                maximum: 25,
                axisLabelStyle: GaugeTextStyle(color: Colors.white),
                ranges: [
                  GaugeRange(
                    color: Color.fromARGB(255, 30, 244, 255),
                    startValue: 0,
                    endValue: 24,
                    startWidth: 5,
                    endWidth: 10,
                  ),
                ],
                pointers: [
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
                    widget: Container(
                      child: Text(
                        displayRate.toStringAsFixed(2),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ),
                    angle: 90,
                    positionFactor: 0.6,
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            isServerSelectionInProgress
                ? "Selecting Server..."
                : 'IP: ${_isp ?? '__'} | ASP: ${_asn ?? '__'} | ISP: ${_asp ?? '__'}',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Color.fromARGB(255, 23, 243, 255),
            ),
            child: Text("Start Testing", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }
}
