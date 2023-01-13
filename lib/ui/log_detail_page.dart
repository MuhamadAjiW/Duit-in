import 'package:duit.in/cubit/log_cubit.dart';
import 'package:duit.in/cubit/log_reader_cubit.dart';
import 'package:duit.in/models/log_model.dart';
import 'package:duit.in/ui/log_edit_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:duit.in/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogDetailPage extends StatefulWidget{
  String logId;
  String uid;
  String keterangan;
  int nilai;
  DateTime waktu;
  String notes;
  LogDetailPage(
      {Key? key,
        required this.logId,
        required this.uid,
        required this.keterangan,
        required this.nilai,
        required this.waktu,
        required this.notes,
      }) : super(key: key);

  @override
  State<LogDetailPage> createState() => _LogDetailPageState();
}

class _LogDetailPageState extends State<LogDetailPage>{

  Widget openingPlate(){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.keyboard_arrow_left,
              size: 28,
              color: black,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 6),
            child: Text('Log Detail', style: defaultTextTheme.copyWith(
              fontSize: 32,
              fontWeight: light,
            )),
          ),
        ],
      ),
    );
  }

  Widget logDetails(){
    return BlocConsumer<LogCubit, LogState>(
        builder: (context, state){
          return Container(
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text("Waktu:",
                    style: defaultTextTheme.copyWith(
                      fontSize: 24,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(this.widget.waktu.toString(),
                    style: defaultTextTheme.copyWith(
                        fontSize: 16
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10,),
                  Text("Keterangan:",
                    style: defaultTextTheme.copyWith(
                      fontSize: 24,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(this.widget.keterangan,
                    style: defaultTextTheme.copyWith(
                        fontSize: 16
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10,),
                  Text("Nilai:",
                    style: defaultTextTheme.copyWith(
                      fontSize: 24,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(currencyForm(this.widget.nilai.toString()),
                    style: defaultTextTheme.copyWith(
                        fontSize: 16
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 10,),
                  Text("Notes:",
                    style: defaultTextTheme.copyWith(
                      fontSize: 24,
                      fontWeight: medium,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(this.widget.notes,
                    style: defaultTextTheme.copyWith(
                        fontSize: 16
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              )
          );
        },
        listener: (context, state){
          if (state is LogSuccess){
            setState(() {
              this.widget.nilai = state.log.nilai;
              this.widget.keterangan = state.log.keterangan;
              this.widget.notes = state.log.notes;
            });
          }
        });
  }

  Widget editButton(){
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: gray,
            width: 1,
          ),
        ),
        child: TextButton(
          onPressed: (){
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => EditLogPage(
                        logId: this.widget.logId,
                        keterangan: this.widget.keterangan,
                        nilai: this.widget.nilai,
                        waktu: this.widget.waktu,
                        notes: this.widget.notes)));
          },
          child: Text(
            'Edit Log',
            style: defaultTextTheme,
          ),
        ),
      ),
    );
  }

  void deletefunction(){
    context.read<LogCubit>().deleteLog(logId: this.widget.logId);
    context.read<LogReaderCubit>().readLogs(this.widget.uid);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  Widget alert(){
    return AlertDialog(
      title: Text("Delete"),
      content: Text("Are you sure?"),
      actions: [
        TextButton(
            onPressed: (){
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text("No")),
        TextButton(
            onPressed: (){
              deletefunction();
            },
            child: Text("Yes")),
      ],
    );
  }


  Widget deleteButton(){
    return Center(
      child: Container(
        width: 300,
        decoration: BoxDecoration(
          color: red,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: gray,
            width: 1,
          ),
        ),
        child: TextButton(
          onPressed: (){
            showDialog(
                context: context,
                builder: (_) => alert(),
                barrierDismissible: true
            );
          },
          child: Text(
            'Delete Log',
            style: defaultTextTheme,
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            SizedBox(height: 50),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5),
              child: openingPlate(),
            ),
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20,),
                  logDetails(),
                  SizedBox(height: 40,),
                  editButton(),
                  SizedBox(height: 10,),
                  deleteButton(),
                ],
              ),
            )
          ],
        )
    );
  }
}
