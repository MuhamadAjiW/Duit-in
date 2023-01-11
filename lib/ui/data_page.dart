
import 'package:duit.in/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
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

            print(dataList);

            List<String> dateList = [];
            for (int daysBefore = 6; daysBefore <= 0; daysBefore--){

            }

            SideTitles _bottomTitles = SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  String text = '';

                  if (value == 0.0){
                    return Text(getDayName(6));
                  }
                  if (value == 1.0){
                    return Text(getDayName(5));
                  }
                  if (value == 2.0){
                    return Text(getDayName(4));
                  }
                  if (value == 3.0){
                    return Text(getDayName(3));
                  }
                  if (value == 4.0){
                    return Text(getDayName(2));
                  }
                  if (value == 5.0){
                    return Text(getDayName(1));
                  }
                  if (value == 6.0){
                    return Text(getDayName(0));
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

  Widget graphDailyCrude(){
    return BlocBuilder<LogReaderCubit, LogReaderState>(
      builder: (context, state){
      if (state is LogReaderSuccess){
        List<double> dataList = [];
        for (int daysBefore = 4; daysBefore >= 0; daysBefore--){
          dataList.add(getsumOfPastDays(state.logs, daysBefore).toDouble());
        }

        double max = getMax(dataList);
        int subtracter = max.toInt() ~/ 4;
        List<String> paramList = [];

        paramList.add(currencyForm('0'));
        for (int i = 3; i > 0; i--){
          paramList.add(currencyForm((max.toInt() - subtracter*i).toString()));
        }
        paramList.add(currencyForm(max.toInt().toString()));

        List<String> dateList = [];
        for (int daysBefore = 6; daysBefore <= 0; daysBefore--){
        }

        List<Feature> features = [
          Feature(
            title: "Pengeluaran",
            color: Colors.blue,
            data: dataList,
          ),
        ];

        return LineGraph(
            features: features,
            size: Size(320, 400),
            labelX: ['Day 1', 'Day 2', 'Day 3', 'Day 4', 'Day 5'],
            labelY: [],
            showDescription: true,
            graphColor: gray,
            graphOpacity: 0.2,
            descriptionHeight: 60,
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

