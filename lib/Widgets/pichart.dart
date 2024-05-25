import 'package:flutter/material.dart';

import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

// ignore: must_be_immutable
class PiChart extends StatefulWidget {
  final List<double> ans;
  PiChart({super.key, required this.ans,});

  @override
  State<PiChart> createState() => _PiChartState();
}

class _PiChartState extends State<PiChart> {
  _PiChartState();

  dynamic dataMap;
  @override
  void initState() {
    super.initState();
    dataMap = {
      "excellent":widget.ans[0],
      "Good": widget.ans[1],
      "Normal": widget.ans[2],
      "Bad":widget.ans[3]
    };
  }


  final legendLabels = <String, String>{
    "Issued Book": "Issued Book legend",
    "Not Issued Book": "Not Issued Book legend",
  };
  // void updateDataMap(double issueBook, double notissuedbook) {
  //   dataMap = {
  //     "Good": issueBook,
  //     "Normal": notissuedbook,
  //     "Bad  ":3.0
  //   };
  // }

  final colorList = <Color>[
    Color(0xff49d232), // Blue color
    Color(0xff0323ff), // Dark blue color
    Color(0xffeaf500), // Darker blue color
    Color(0xffff3f00),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
  ];
  final ChartType _chartType = ChartType.disc;

  final double _ringStrokeWidth = 32;
  final double _chartLegendSpacing = 32;

  final bool _showLegendsInRow = false;
  final bool _showLegends = true;
  final bool _showLegendLabel = false;

  final bool _showChartValueBackground = true;
  final bool _showChartValues = true;
  final bool _showChartValuesInPercentage = false;
  final bool _showChartValuesOutside = false;

  final bool _showGradientColors = false;

  // LegendShape? _legendShape = LegendShape.circle;
  final LegendPosition _legendPosition = LegendPosition.right;

  int key = 0;
  @override
  Widget build(BuildContext context) {
    final chart = PieChart(
      key: ValueKey(key),
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: _chartLegendSpacing,
      chartRadius: math.min(MediaQuery.of(context).size.width / 3.2, 300),
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: _chartType,
      legendLabels: _showLegendLabel ? legendLabels : {},
      legendOptions: LegendOptions(
        showLegendsInRow: _showLegendsInRow,
        legendPosition: _legendPosition,
        showLegends: _showLegends,
        legendTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: _showChartValueBackground,
        showChartValues: _showChartValues,
        showChartValuesInPercentage: _showChartValuesInPercentage,
        showChartValuesOutside: _showChartValuesOutside,
      ),
      ringStrokeWidth: _ringStrokeWidth,
      emptyColor: Colors.grey,
      gradientList: _showGradientColors ? gradientList : null,
      emptyColorGradient: const [
        Color(0xff6c5ce7),
        Colors.blue,
      ],
      baseChartColor: Colors.transparent,
    );
    return Container(
          alignment: Alignment.center,
          height: 200,
          width: double.maxFinite,
          child: Center(child: chart)
    );
  }
}