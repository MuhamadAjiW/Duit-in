import 'dart:math';

import 'package:duit.in/models/log_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';

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

