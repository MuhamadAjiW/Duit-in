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
  if (val.length > 3){
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

int getsumOfPastDays(
  List<LogModel> loglist,
  int daysBefore,
  ){
  DateTime requestedDate = DateTime.now().subtract(Duration(days: daysBefore));
  int sum = 0;
  for(int i = 0; i < loglist.length; i++){
    if (loglist[i].waktu.day == requestedDate.day
        && loglist[i].waktu.month == requestedDate.month
        && loglist[i].waktu.year == requestedDate.year
    ){
      sum += loglist[i].nilai;
    }
  }return sum;
}

double getMax(
  List<double> doubleList
){
  if (doubleList.isEmpty){
    return 0;
  }
  else if (doubleList.length == 1) {
    return doubleList[0];
  }
  else{
    double comparator = doubleList[0];
    for(int i = 1; i < doubleList.length; i++){
      if (comparator < doubleList[i]){
        comparator = doubleList[i];
      }
    }
    return comparator;
  }
}

String getDayName(
  int MinDayCoeff
){
  DateTime requestedDate = DateTime.now().subtract(Duration(days: MinDayCoeff));

  print(requestedDate);
  if (requestedDate.weekday == 1){
    return "Mon";
  }
  if (requestedDate.weekday == 2){
    return "Tue";
  }
  if (requestedDate.weekday == 3){
    return "Wed";
  }
  if (requestedDate.weekday == 4){
    return "Thu";
  }
  if (requestedDate.weekday == 5){
    return "Fri";
  }
  if (requestedDate.weekday == 6){
    return "Sat";
  }
  if (requestedDate.weekday == 7){
    return "Sun";
  }

  return '';
}
