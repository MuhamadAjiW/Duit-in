import 'package:duit.in/models/log_model.dart';
import 'package:duit.in/widgets/customlogbutton.dart';
import 'package:duit.in/widgets/customnavbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:duit.in/cubit/log_reader_cubit.dart';

import 'package:duit.in/theme/theme.dart';
import 'package:duit.in/ui/log_detail_page.dart';

class LogsPage extends StatefulWidget{
  const LogsPage({Key? key}) : super(key: key);
  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage>{
  int category = 0;

  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Logs', style: defaultTextTheme.copyWith(
            fontSize: 32,
            fontWeight: light,
          )),
        ],
      ),
    );
  }

  Widget listOfLogs(){
    return BlocConsumer<LogReaderCubit, LogReaderState>(
        builder: (context, state){
          if (state is LogReaderLoading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          else if (state is LogReaderSuccess){

            var logs = state.logs;
            if (category == 1){
              logs = logs.where((log) => log.keterangan == "Pendapatan").toList();
            }
            else{
              logs = logs.where((log) => log.keterangan != "Pendapatan").toList();
            }


            if (logs.isNotEmpty){
              return Container(
                height: MediaQuery.of(context).size.height - 260,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: logs.length,
                  itemBuilder: (_,index){
                      return Container(
                        child: Column(
                          children: [
                              CustomLogButton(
                                buttonText: logs[logs.length - 1 - index].keterangan,
                                isIncome: (logs[logs.length - 1 - index].keterangan == "pendapatan"),
                                timeMarker: getLogTimeMarker(logs[logs.length - 1 - index].waktu),
                                value: currencyForm(logs[logs.length - 1 - index].nilai.toString()),
                                onPressed: (){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LogDetailPage(
                                              uid: logs[logs.length - 1 - index].uid,
                                              keterangan: logs[logs.length - 1 - index].keterangan,
                                              nilai: logs[logs.length - 1 - index].nilai,
                                              waktu: logs[logs.length - 1 - index].waktu,
                                              notes: logs[logs.length - 1 - index].notes)));
                                },
                              ),
                              SizedBox(height: 10,),
                          ],
                        ),
                      );
                  },
                ),
              );
            }
            else{
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text("No logs available", style: defaultTextTheme,),
              );
            }
          }
          else{
            return nullWidget;
          }
        },
        listener: (context, state){
          if (state is LogReaderFailed){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.error),
              backgroundColor: red,
            ));
          }
        }
    );
  }

  Widget categorySelect(){
    return CustomNavBar(
        category1: "Transactions",
        category2: "Income",
        category3: "Expenses",
        ratio1: 5,
        ratio2: 4,
        ratio3: 4,
        sideratio: 1,
        onPressed1: (){
          setState(() {
            category = 0;
          });
        },
        onPressed2: (){
          print("ctg "+category.toString());
          setState(() {
            category = 1;
          });
          print("ctg "+category.toString());
        },
        onPressed3: (){
          setState(() {
            category = 2;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 85,),
          openingPlate(),
          SizedBox(height: 30,),
          categorySelect(),
          listOfLogs(),
        ],
      ),
    );
  }
}

