import 'package:equatable/equatable.dart';

class LogModel extends Equatable{
  final String keterangan;
  final int nilai;
  final String uid;
  final DateTime waktu;
  final String notes;

  LogModel({
    required this.uid,
    required this.nilai,
    required this.keterangan,
    required this.waktu,
    this.notes = '',
  });

  static LogModel fromJson(Map<String, dynamic> json){
    return LogModel(
        uid: json['uid'],
        nilai: json['nilai'],
        keterangan: json['keterangan'],
        waktu: json['waktu'].toDate(),
        notes: json['notes'],
    );
  }

  @override
  List<Object?> get props {
    return [uid, nilai, keterangan, waktu, notes];
  }
}

//Fungsi lain yang berkaitan
String currencyForm(String val){
  if (val.length > 4){
    int remainder = val.length % 3;
    String initial = val.substring(0, remainder);
    String marked = val.substring(remainder);

    marked = marked.replaceAllMapped(RegExp(r".{3}"), (match) => "${match.group(0)}.");

    String retval = initial + '.' + marked;
    retval = retval.substring(0, retval.length -1);
    retval = 'Rp' + retval + ',00';

    return retval;
  }
  else{
    return val;
  }
}

int getsum(List<LogModel> loglist){
  int sum = 0;
  for(int i = 0; i < loglist.length; i++){
    sum += loglist[i].nilai;
  }return sum;
}

int getsumOfDay(List<LogModel> loglist){
  int sum = 0;
  for(int i = 0; i < loglist.length; i++){
    if (loglist[i].waktu.day == DateTime.now().day
    && loglist[i].waktu.month == DateTime.now().month
    && loglist[i].waktu.year == DateTime.now().year
    ){
      sum += loglist[i].nilai;
    }
  }return sum;
}

