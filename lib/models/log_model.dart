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
    return 'Rp' + val + ',00';
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
  int MinDayCoeff,
  bool shortened,
){
  DateTime requestedDate = DateTime.now().subtract(Duration(days: MinDayCoeff));

  print(requestedDate);
  if (shortened){
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
  }
  else{
    if (requestedDate.weekday == 1){
      return "Monday";
    }
    if (requestedDate.weekday == 2){
      return "Tuesday";
    }
    if (requestedDate.weekday == 3){
      return "Wednesday";
    }
    if (requestedDate.weekday == 4){
      return "Thursday";
    }
    if (requestedDate.weekday == 5){
      return "Friday";
    }
    if (requestedDate.weekday == 6){
      return "Saturday";
    }
    if (requestedDate.weekday == 7){
      return "Sunday";
    }
  }

  return '';
}

String getMonthName(
    DateTime requestedDate
    ){

  print(requestedDate);
  if (requestedDate.month == 1){
    return "Jan";
  }
  if (requestedDate.month == 2){
    return "Feb";
  }
  if (requestedDate.month == 3){
    return "Mar";
  }
  if (requestedDate.month == 4){
    return "Apr";
  }
  if (requestedDate.month == 5){
    return "May";
  }
  if (requestedDate.month == 6){
    return "Jun";
  }
  if (requestedDate.month == 7){
    return "Jul";
  }
  if (requestedDate.month == 8){
    return "Aug";
  }
  if (requestedDate.month == 9){
    return "Sept";
  }
  if (requestedDate.month == 10){
    return "Oct";
  }
  if (requestedDate.month == 11){
    return "Nov";
  }
  if (requestedDate.month == 12){
    return "Dec";
  }
  return '';
}

String getLogTimeMarker(
  DateTime time
){
  String retval = '';

  if (
  time.day == DateTime.now().day
&& time.month == DateTime.now().month
&& time.year == DateTime.now().year){
    retval += "Today, at " + time.hour.toString() + '.' + time.minute.toString();
  }
  else if (
  time.day == DateTime.now().subtract(Duration(days: 1)).day
&& time.month == DateTime.now().subtract(Duration(days: 1)).month
&& time.year == DateTime.now().subtract(Duration(days: 1)).year){
    retval += "Yesterday, at " + time.hour.toString() + '.' + time.minute.toString();
  }
  else if(DateTime.now().isAfter(DateTime.now().subtract(Duration(days: 7)))){
    int diff = DateTime.now().difference(time).inDays;
    retval += getDayName(diff, false) + ", at " + time.hour.toString() + '.' + time.minute.toString();;
  }
  else{
    getMonthName(time);
    retval += time.day.toString() + ' ' + getMonthName(time) + ' ' + (time.year).toString();
  }

  return retval;
}
