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