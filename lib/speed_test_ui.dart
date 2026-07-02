import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_internet_speed_test/flutter_internet_speed_test.dart';
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
  double _downloadRate = 0.0;
  double _uploadRate = 0.0;
  double displayRate = 0.0;
  bool isServerSelectionInProgress = false;
  bool istestingStarted = false;
  String? _isp;
  String? _ip;
  String? _asn;
  String unitText = '';
  final speedTest = FlutterInternetSpeedTest();

  bool get _isSupportedPlatform =>
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);

  void _showUnsupportedPlatformMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Speed testing is supported on Android and iOS only.'),
      ),
    );
  }

  double get _progressFraction => (displayProgress / 100.0).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0D1B2A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Speed Test',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 260,

                        child: SfRadialGauge(
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
                        ),
                      ),
                      const SizedBox(height: 20),
                      LinearPercentIndicator(
                        percent: _progressFraction,
                        lineHeight: 18,
                        animation: true,
                        animateFromLastPercent: true,
                        animationDuration: 250,
                        barRadius: const Radius.circular(20),
                        backgroundColor: Colors.white12,
                        progressColor: Colors.cyan,
                        center: Text(
                          '${displayProgress.toStringAsFixed(0)} %',
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.download,
                              color: Colors.greenAccent,
                              size: 35,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Download',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_downloadRate.toStringAsFixed(2)} $unitText',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: .08),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.upload,
                              color: Colors.orange,
                              size: 35,
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Upload',
                              style: TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${_uploadRate.toStringAsFixed(2)} $unitText',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: .08),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.public, color: Colors.cyan, size: 35),
                      const SizedBox(height: 10),
                      Text(
                        isServerSelectionInProgress
                            ? 'Selecting Best Server...'
                            : 'ISP : ${_isp ?? '--'}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'ASN : ${_asn ?? '--'}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'IP : ${_ip ?? '--'}',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: _isSupportedPlatform
                        ? () {
                            testingfunction();
                          }
                        : _showUnsupportedPlatformMessage,
                    child: const Text(
                      'START TEST',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void testingfunction() {
    resetVlaues();

    speedTest.startTesting(
      onStarted: () {
        setState(() {
          istestingStarted = true;
        });
      },
      onCompleted: (TestResult download, TestResult upload) {
        setState(() {
          unitText = download.unit == SpeedUnit.kbps ? 'kb/s' : 'Mb/s';
          _downloadRate = download.transferRate;
          displayProgress = 100.0;
          displayRate = _downloadRate;
        });
        setState(() {
          unitText = upload.unit == SpeedUnit.kbps ? 'kb/s' : 'Mb/s';
          _uploadRate = upload.transferRate;
          displayProgress = 100.0;
          displayRate = 0.0;
          istestingStarted = false;
        });
      },
      onProgress: (double percent, TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'kb/s' : 'Mb/s';
          if (data.type == TestType.download) {
            _downloadRate = data.transferRate;
            displayRate = _downloadRate;
            displayProgress = percent;
          } else {
            _uploadRate = data.transferRate;
            displayRate = _uploadRate;
            displayProgress = percent;
          }
        });
      },
      onError: (String errorMessage, String speedTestError) {
        debugPrint('error : $errorMessage$speedTestError');
      },
      onDefaultServerSelectionInProgress: () {
        setState(() {
          isServerSelectionInProgress = true;
        });
      },
      onDefaultServerSelectionDone: (Client? client) {
        setState(() {
          isServerSelectionInProgress = false;
          _ip = client?.ip;
          _asn = client?.asn;
          _isp = client?.isp;
        });
      },
      onDownloadComplete: (TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'kb/s' : 'Mb/s';
          _downloadRate = data.transferRate;
          displayRate = _downloadRate;
        });
      },
      onUploadComplete: (TestResult data) {
        setState(() {
          unitText = data.unit == SpeedUnit.kbps ? 'kb/s' : 'Mb/s';
          _uploadRate = data.transferRate;
          displayRate = _uploadRate;
        });
      },
    );
  }

  void resetVlaues() {
    setState(() {
      _downloadRate = 0.0;
      _uploadRate = 0.0;
      displayRate = 0.0;
      istestingStarted = false;
      displayProgress = 0.0;
      _ip = null;
      _isp = null;
      _asn = null;
    });
  }
}
