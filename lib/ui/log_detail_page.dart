import 'package:flutter/material.dart';
import 'package:liburan/theme/theme.dart';

class LogDetailPage extends StatefulWidget{
  final String keterangan;
  final int nilai;
  final DateTime waktu;
  final String notes;
  const LogDetailPage(
      {Key? key,
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
          Text(this.widget.nilai.toString(),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 60,),
              openingPlate(),
              SizedBox(height: 20,),
              logDetails(),
            ],
          ),
        )
    );
  }
}
