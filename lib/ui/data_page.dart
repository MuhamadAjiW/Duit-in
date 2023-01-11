
import 'package:duit.in/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';

import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:duit.in/theme/theme.dart';

class DataPage extends StatefulWidget{
  const DataPage({Key? key}) : super(key: key);
  @override
  State<DataPage> createState() => _DataPageState();
}

class _DataPageState extends State<DataPage>{
  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Data', style: defaultTextTheme.copyWith(
            fontSize: 32,
            fontWeight: light,
          )),
        ],
      ),
    );
  }

  Widget graphDaily(){
    return BlocBuilder<LogReaderCubit, LogReaderState>(
        builder: (context, state){
          if (state is LogReaderSuccess){
            List<FlSpot> dataList = [];
            for (int daysBefore = 6; daysBefore >= 0; daysBefore--){
              dataList.add(
                  FlSpot(
                      6 - daysBefore.toDouble(),
                      getsumOfPastDays(state.logs, daysBefore)
                          .toDouble()));
            }

            SideTitles _bottomTitles = SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String text = '';

                  if (value == 0.0){
                    return Text(getDayName(6, true));
                  }
                  if (value == 1.0){
                    return Text(getDayName(5, true));
                  }
                  if (value == 2.0){
                    return Text(getDayName(4, true));
                  }
                  if (value == 3.0){
                    return Text(getDayName(3, true));
                  }
                  if (value == 4.0){
                    return Text(getDayName(2, true));
                  }
                  if (value == 5.0){
                    return Text(getDayName(1, true));
                  }
                  if (value == 6.0){
                    return Text(getDayName(0, true));
                  }
                  return Text(text);
                }
            );

            return AspectRatio(
              aspectRatio: 2,
              child: LineChart(
                LineChartData(
                  lineBarsData: [
                    LineChartBarData(
                        spots: dataList,
                        isCurved: false,
                        dotData: FlDotData(
                          show: true,
                        ),
                        color: Colors.red
                    ),
                  ],
                  borderData: FlBorderData(
                      border: const Border(bottom: BorderSide(), left: BorderSide())),
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  ),
                ),
              ),
            );
          } else{
            return nullWidget;
          }
        });
  }


  Widget dataPlate(){
    return BlocBuilder<LogReaderCubit, LogReaderState>(builder: (context, state){
      if (state is LogReaderSuccess){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Spending graphs', style: defaultTextTheme.copyWith(
                fontSize: 16,
                fontWeight: light,
              )),
            ],
          ),
        );
      }
      else return SizedBox();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: 60,),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: openingPlate(),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 25),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              dataPlate(),
              SizedBox(height: 20,),
              graphDaily(),
            ],
          ),
        )
      ],
    );
  }
}

