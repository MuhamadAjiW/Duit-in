import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liburan/cubit/log_reader_cubit.dart';

import 'package:liburan/theme/theme.dart';
import 'package:liburan/ui/log_detail_page.dart';

class LogsPage extends StatefulWidget{
  const LogsPage({Key? key}) : super(key: key);
  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage>{
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

            if (logs.isNotEmpty){
              return Container(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: logs.length,
                  itemBuilder: (_,index){
                      return Container(
                        child: Column(
                          children: [
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogDetailPage(
                                            keterangan: logs[index].keterangan,
                                            nilai: logs[index].nilai,
                                            waktu: logs[index].waktu,
                                            notes: logs[index].notes)));
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                        color: gray,
                                        width: 1
                                    )
                                ),
                                width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10,),
                                      Text("  "+logs[index].waktu.toString(),
                                      style: defaultTextTheme.copyWith(
                                        fontSize: 14
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 4,),
                                      Text("  "+logs[index].keterangan,
                                        style: defaultTextTheme.copyWith(
                                            fontSize: 12
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text("  "+logs[index].nilai.toString(),
                                        style: defaultTextTheme.copyWith(
                                            fontSize: 12
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: 15,),
                                    ],
                                  ),
                              ),
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
              return Text("No logs available");
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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 60,),
          openingPlate(),
          listOfLogs(),
        ],
      ),
    );
  }
}

